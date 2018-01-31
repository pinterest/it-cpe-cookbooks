cpe_setupassistant Cookbook
=========================
Install a profile to manage SetupAssistant settings.

Requirements
------------
Mac OS X

Attributes
----------
* node['cpe_setupassistant']['once']['DidSeeCloudSetup']
* node['cpe_setupassistant']['once']['DidSeeSiriSetup']
* node['cpe_setupassistant']['once']['LastSeenBuddyBuildVersion']
* node['cpe_setupassistant']['once']['LastSeenCloudProductVersion']
* node['cpe_setupassistant']['once']['RunNonInteractive']
* node['cpe_setupassistant']['managed']['SkipCloudSetup']

Usage
-----
The profile will manage the `com.apple.SetupAssistant` preference domain.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`

This cookbook can deliver a profile with two different payloads for configuring the Setup Assistant.  All keys are nil by default which will result in no profile being installed.  Common usage will be to use one or the other payload.

You can add any arbitrary keys to `node['cpe_setupassistant']['once']` to have them added to your profile.  As long as the values are not nil and create a valid profile, this cookbook will install and manage them. While `node['cpe_setupassistant']['once']`, at this time, only supports the 'SkipCloudSetup' key.

The most common use case is for client machines that you want SetupAssistant to be disabled on. You can also use node attributes to dynamically update these fields without writing new code:

    # Disable SetupAssistant
    node.default['cpe_setupassistant']['once']['DidSeeCloudSetup'] = true
    node.default['cpe_setupassistant']['once']['LastSeenBuddyBuildVersion'] = '15G31'
    node.default['cpe_setupassistant']['once']['LastSeenCloudProductVersion'] = '10.11.6'
    node.default['cpe_setupassistant']['once']['RunNonInteractive'] = true

    # Disable SetupAssistant (dynamic)
    node.default['cpe_setupassistant']['once']['DidSeeCloudSetup'] = true
    node.default['cpe_setupassistant']['once']['LastSeenBuddyBuildVersion'] =
      node['platform_build']
    node.default['cpe_setupassistant']['once']['LastSeenCloudProductVersion'] =
      node['platform_version']
    node.default['cpe_setupassistant']['once']['RunNonInteractive'] = true

    # Disable SetupAssistant. Only works on 10.10+
    node.default['cpe_setupassistant']['managed']['SkipCloudSetup'] = true
