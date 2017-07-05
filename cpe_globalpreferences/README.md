cpe_globalpreferences Cookbook
=========================
Install a profile the Global Preferences.

Requirements
------------
macOS

Attributes
----------
* node['cpe_globalpreferences']
* node['cpe_globalpreferences']['MultipleSessionEnabled']
* node['cpe_globalpreferences']['NSQuitAlwaysKeepsWindows']

Usage
-----
The profile will manage the `.GlobalPreferences` preference domain.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`

The profile delivers a payload of all keys in `node['cpe_globalpreferences']` that are non-nil values.  The two provided keys `node['cpe_globalpreferences']['MultipleSessionEnabled']` and `node['cpe_globalpreferences']['NSQuitAlwaysKeepsWindows']` are nil, so that no profile is installed by default.

You can add any arbitrary keys to `node['cpe_globalpreferences']` to have them added to your profile.  As long as the values are not nil and create a valid profile, this cookbook will install and manage them.

    # Disable Fast User Switching
    node.default['cpe_globalpreferences']['MultipleSessionEnabled'] = 0
    # Don't Restore Windows
    node.default['cpe_globalpreferences']['NSQuitAlwaysKeepsWindows'] = 0
