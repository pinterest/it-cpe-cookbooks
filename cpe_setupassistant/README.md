cpe_setupassistant Cookbook
=========================
Install a profile to manage SetupAssistant settings.
Requirements
------------
Mac OS X

Attributes
----------
* node['cpe_setupassistant']
* node['cpe_setupassistant']['DidSeeCloudSetup']
* node['cpe_setupassistant']['DidSeeSiriSetup']
* node['cpe_setupassistant']['LastSeenBuddyBuildVersion']
* node['cpe_setupassistant']['LastSeenCloudProductVersion']
* node['cpe_setupassistant']['RunNonInteractive']

Usage
-----
The profile will manage the `com.apple.SetupAssistant` preference domain.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.pinterest.chef`

The profile delivers a payload of all keys in `node['cpe_setupassistant']` that are non-nil values.  The four provided keys `node['cpe_setupassistant']['DidSeeCloudSetup']`, `node['cpe_setupassistant']['LastSeenBuddyBuildVersion']`, `node['cpe_setupassistant']['LastSeenCloudProductVersion']` and `node['cpe_setupassistant']['RunNonInteractive']` are nil, so that no profile is installed by default.

You can add any arbitrary keys to `node['cpe_setupassistant']` to have them added to your profile.  As long as the values are not nil and create a valid profile, this cookbook will install and manage them.

The most common use case is for client machines that you want SetupAssistant to be disabled on. You can also use node attributes to dynamically update these fields without writing new code:

    # Disable SetupAssistant
    node.default['cpe_setupassistant']['DidSeeCloudSetup'] = true
    node.default['cpe_setupassistant']['LastSeenBuddyBuildVersion'] = '15G31'
    node.default['cpe_setupassistant']['LastSeenCloudProductVersion'] = '10.11.6'
    node.default['cpe_setupassistant']['RunNonInteractive'] = true

    # Disable SetupAssistant (dynamic)
    node.default['cpe_setupassistant']['DidSeeCloudSetup'] = true
    node.default['cpe_setupassistant']['LastSeenBuddyBuildVersion'] =
      node['platform_build']
    node.default['cpe_setupassistant']['LastSeenCloudProductVersion'] =
      node['platform_version']
    node.default['cpe_setupassistant']['RunNonInteractive'] = true
