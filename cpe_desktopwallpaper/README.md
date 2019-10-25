cpe_desktopwallpaper Cookbook
=========================

Install a profile to manage Desktop settings.

Requirements
------------
macOS

Attributes
----------
* node['cpe_desktopwallpaper']
* node['cpe_desktopwallpaper']['OverridePicturePath']

Usage
-----

The profile will manage the `com.apple.desktop` preference domain.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`

The profile delivers a payload of all keys in `node['cpe_desktopwallpaper']` that are non-nil values.  The key `node['cpe_desktopwallpaper']['OverridePicturePath']` is nil, so that no profile is installed by default.

The most common use case is for client machines that are heavily locked down.

    # Set Wallpaper
    node.default['cpe_desktopwallpaper']['OverridePicturePath'] = '/Library/Desktop Pictures/El Capitan.jpg'
