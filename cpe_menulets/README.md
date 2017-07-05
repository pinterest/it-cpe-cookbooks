cpe_menulets Cookbook
=========================
Install a profile to manage menulets

Requirements
------------
macOS

Attributes
----------
* node['cpe_menulets']

Usage
-----
The profile will manage the `com.apple.systemuiserver` preference domain.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`

The profile delivers a payload of all keys in `node['cpe_menulets']` that are non-nil values.  The provided defaults are nil, so that no profile is installed by default.

You can add any arbitrary keys to `node['cpe_menulets']` to have them added to your profile.  As long as the values are not nil and create a valid profile, this cookbook will install and manage them.

The most common use case is for showing the Keychain Menuluet.

    # Enable Keychain Menulet
    node.default['cpe_menulets'] = [
      '/Applications/Utilities/Keychain Access.app/Contents/Resources/Keychain.menu'
    ]
