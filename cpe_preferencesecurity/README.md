cpe_preferencesecurity Cookbook
========================
Install a profile to manage screensaver settings.


Attributes
----------
* node['cpe_preferencesecurity']
* node['cpe_preferencesecurity']['dontAllowLockMessageUI']

Usage
-----
The profile will manage the `com.apple.preference.security` preference domain.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`

    # Do not allow lock screen UI
    node.default['cpe_preferencesecurity']['dontAllowLockMessageUI'] = 300
