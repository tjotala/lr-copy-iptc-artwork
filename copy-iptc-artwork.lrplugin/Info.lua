--[[----------------------------------------------------------------------------

 Copy IPTC Artwork to Keywords & Title
 Copyright 2016 Tapani Otala

--------------------------------------------------------------------------------

Info.lua
Summary information for the plug-in.

Adds menu items to Lightroom.

------------------------------------------------------------------------------]]

return {
	
	LrSdkVersion = 5.0,
	LrSdkMinimumVersion = 5.0, -- minimum SDK version required by this plug-in

	LrToolkitIdentifier = "com.tjotala.lightroom.copy-iptc-artwork",

	LrPluginName = LOC( "$$$/CopyIptcArtwork/PluginName=Copy IPTC Artwork" ),
	
	-- Add the menu item to the File menu.
	
	LrExportMenuItems = {
	    {
		    title = LOC( "$$$/CopyIptcArtwork/LibraryMenuItem=Copy IPTC Artwork" ),
		    file = "CopyIptcArtworkMenuItem.lua",
		},
	},

	-- Add the menu item to the Library menu.
	
	LrLibraryMenuItems = {
	    {
		    title = LOC( "$$$/CopyIptcArtwork/LibraryMenuItem=Copy IPTC Artwork" ),
		    file = "CopyIptcArtworkMenuItem.lua",
		},
	},

	VERSION = { major=1, minor=0, revision=0, build=1, },

}


	