cpe_softwareupdate Cookbook
========================
Install a profile to manage softwareupdate settings.

Requirements
----------
This cookbook requires Chef 14 and higher to run and depends on the following cookbooks:

* cpe_profiles

These cookbooks are offered by Facebook in the [IT-CPE](https://github.com/facebook/IT-CPE) repository.

Attributes
----------
* node['cpe_softwareupdate']
* node['cpe_softwareupdate']['commerce']['AutoUpdate']
* node['cpe_softwareupdate']['commerce']['AutoUpdateRestartRequired']
* node['cpe_softwareupdate']['su']['AllowPreReleaseInstallation']
* node['cpe_softwareupdate']['su']['AutomaticCheckEnabled']
* node['cpe_softwareupdate']['su']['AutomaticDownload']
* node['cpe_softwareupdate']['su']['CatalogURL']
* node['cpe_softwareupdate']['su']['ConfigDataInstall']
* node['cpe_softwareupdate']['su']['CriticalUpdateInstall']
* node['cpe_softwareupdate']['su']['SUDisableEVCheck']
* node['cpe_softwareupdate']['su']['AutomaticallyInstallMacOSUpdates']
* node['cpe_softwareupdate']['stagent']['AutoUpdate']

Usage
-----
The profile will manage the following preference domains:
- com.apple.SoftwareUpdate
- com.apple.commerce
- com.apple.storeagent

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`

The profile delivers a payload for the above keys in `node['cpe_softwareupdate']`.  The three provided have a sane default, which can be overridden in another recipe if desired.

For example, you could tweak the above values

    # Enable Auto Update from App Store (Not reflected in UI)
    node.default['cpe_softwareupdate']['commerce']['AutoUpdate'] = true
    # Enabled Auto Update of delta/combo updates from App Store (Not reflected in UI)
    node.default['cpe_softwareupdate']['commerce']['AutoUpdateRestartRequired'] = true
    # Allow beta access
    node.default['cpe_softwareupdate']['su']['AllowPreReleaseInstallation'] = true
    # Automatically check for updates
    node.default['cpe_softwareupdate']['su']['AutomaticCheckEnabled'] = true
    # Download newly available updates in the background
    node.default['cpe_softwareupdate']['su']['AutomaticDownload'] = true
    # Use internal SUS
    node.default['cpe_softwareupdate']['su']['CatalogURL'] = 'https://sus.domain.tld'
    # Download system data files
    node.default['cpe_softwareupdate']['su']['ConfigDataInstall'] = true
    # Download security updates
    node.default['cpe_softwareupdate']['su']['CriticalUpdateInstall'] = true
    # Disable TLS extended validation check
    node.default['cpe_softwareupdate']['su']['SUDisableEVCheck'] = true
    # Enable automatic macOS updates in Mojave
    node.default['cpe_softwareupdate']['su']['AutomaticallyInstallMacOSUpdates'] = true
    # Enable automatic app store updates of installed apps
    node.default['cpe_softwareupdate']['stagent']['AutoUpdate'] = true
