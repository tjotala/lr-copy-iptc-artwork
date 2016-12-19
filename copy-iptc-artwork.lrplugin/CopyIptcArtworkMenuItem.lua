--[[----------------------------------------------------------------------------

 Copy IPTC Artwork
 Copyright 2016 Tapani Otala

--------------------------------------------------------------------------------

CopyIptcArtworkMenuItem.lua

------------------------------------------------------------------------------]]

-- Access the Lightroom SDK namespaces.
local LrLogger = import "LrLogger"
local LrApplication = import "LrApplication"
local LrTasks = import "LrTasks"
local LrProgressScope = import "LrProgressScope"

-- Create the logger and enable the print function.
local myLogger = LrLogger( "com.tjotala.lightroom.copy-iptc-artwork" )
myLogger:enable( "logfile" ) -- Pass either a string or a table of actions.

--------------------------------------------------------------------------------
-- Write trace information to the logger.

local function trace( message, ... )
	myLogger:tracef( message, unpack( arg ) )
end

--------------------------------------------------------------------------------
-- Launch a background task to go copy IPTC artwork metadata to the keywords & title

local function copyIptcArtwork()
	LrTasks.startAsyncTask(
		function( )
			trace( "copyIptcArtwork: enter" )
			local catalog = LrApplication.activeCatalog()
			local collection = getTargetCollection(catalog)

			catalog:withWriteAccessDo( LOC( "$$$/CopyIptcArtwork/ActionName=Copy IPTC Artwork" ),
				function( context )
					local progressScope = LrProgressScope {
						title = LOC( "$$$/CopyIptcArtwork/ProgressScopeTitle=Copying IPTC Artwork" ),
						functionContext = context,
					}
					progressScope:setCancelable( true )

					-- Enumerate through all selected photos in the catalog
					local photos = catalog:getTargetPhotos()
					trace( "checking %d photos", #photos )
					for i, photo in ipairs(photos) do
						if progressScope:isCanceled() then
							break
						end

						-- Update the progress bar
						local fileName = photo:getFormattedMetadata( "fileName" )
						progressScope:setCaption( LOC( "$$$/CopyIptcArtwork/ProgressCaption=^1 (^2 of ^3)", fileName, i, #photos ) )
						progressScope:setPortionComplete( i, #photos )

						trace( "photo %d of %d: %s", i, #photos, fileName )

						if #foundPhotos > 1 then
							trace( "found %d matching photos of %s", #foundPhotos, fileName )
							for i, found in ipairs(foundPhotos) do
								trace( "  matched: %s from %s", found:getFormattedMetadata( "fileName" ), found:getFormattedMetadata( "folderName" ) )
							end
							collection:addPhotos( foundPhotos )
						end

						LrTasks.yield()
					end

					progressScope:done()
					catalog:setActiveSources { collection }
				end
			)
			trace( "copyiptcArtwork: exit" )
		end
	)
end

--------------------------------------------------------------------------------
-- Begin the search
copyIptcArtwork()
