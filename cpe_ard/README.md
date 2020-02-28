cpe_ard Cookbook
=========================
Install a profile to manage Apple Remote Desktop Application settings.

This cookbook depends on the following cookbooks

* cpe_profiles
* cpe_utils
* uber_helpers

These cookbooks are offered by Facebook in the [IT-CPE](https://github.com/facebook/IT-CPE) repository and Uber in the [cpe-chef-cookbooks](https://github.com/uber/cpe-chef-cookbooks) repository.

Requirements
------------
Mac OS X

Notes
------------
As of macOS 10.14 and higher, you cannot enforce the enablement of Apple Remote Desktop functionality without a TCC profile installed via UAMDM/DEP.

Please follow this [KB article](https://support.apple.com/en-us/HT209161) to create the appropriate profile that chef will check against.

Attributes
----------
* node['cpe_ard']
* node['cpe_ard']['profile']['prefs']
* node['cpe_ard']['profile']['prefs']['AdminConsoleAllowsRemoteControl']
* node['cpe_ard']['profile']['prefs']['LoadRemoteManagementMenuExtra']
* node['cpe_ard']['kickstart']
* node['cpe_ard']['kickstart']['enable']
* node['cpe_ard']['kickstart']['manage']
* node['cpe_ard']['kickstart']['tcc_profile_id']

Usage
-----
The profile will manage the `com.apple.RemoteManagement` preference domain.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`

The profile delivers a payload of all keys in `node['cpe_ard']` that are non-nil values.  The two provided keys `node['cpe_ard']['AdminConsoleAllowsRemoteControl']` and `node['cpe_ard']['LoadRemoteManagementMenuExtra']` are nil, so that no profile is installed by default.

You can add any arbitrary keys to `node['cpe_ard']` to have them added to your profile.  As long as the values are not nil and create a valid profile, this cookbook will install and manage them.

The most common use case is for service machines with Apple Remote Desktop installed.

    # Force Apple Remote Desktop (Application) use when application is open.
    node.default['cpe_ard']['profile']['prefs']['AdminConsoleAllowsRemoteControl'] = true
    node.default['cpe_ard']['profile']['prefs']['LoadRemoteManagementMenuExtra'] = true

    # Enable Apple Remote Desktop access
    node.default['cpe_ard']['kickstart']['manage'] = true
    node.default['cpe_ard']['kickstart']['enable'] = true
    # TCC Profile identifier for 10.14 + machines
    node.default['cpe_ard']['kickstart']['tcc_profile_id'] = 'your profile identifier'

If you simply want to disable Apple Remote Desktop access.

    # Disable Apple Remote Desktop access
    node.default['cpe_ard']['kickstart']['manage'] = true
