cpe_ard Cookbook
=========================
Install a profile to manage Apple Remote Desktop Application settings.

Requirements
------------
Mac OS X

Attributes
----------
* node['cpe_ard']
* node['cpe_ard']['AdminConsoleAllowsRemoteControl']
* node['cpe_ard']['LoadRemoteManagementMenuExtra']

Usage
-----
The profile will manage the `com.apple.RemoteManagement` preference domain.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`

The profile delivers a payload of all keys in `node['cpe_ard']` that are non-nil values.  The two provided keys `node['cpe_ard']['AdminConsoleAllowsRemoteControl']` and `node['cpe_ard']['LoadRemoteManagementMenuExtra']` are nil, so that no profile is installed by default.

You can add any arbitrary keys to `node['cpe_ard']` to have them added to your profile.  As long as the values are not nil and create a valid profile, this cookbook will install and manage them.

The most common use case is for service machines with Apple Remote Desktop installed.

    # Force Apple Remote Desktop use when application is open.
    node.default['cpe_ard']['AdminConsoleAllowsRemoteControl'] = true
    node.default['cpe_ard']['LoadRemoteManagementMenuExtra'] = true
