cpe_softwareupdate Cookbook
========================
Install a profile to manage softwareupdate settings.

Attributes
----------
* node['cpe_softwareupdate']
* node['cpe_softwareupdate']['commerce']['AutoUpdate']
* node['cpe_softwareupdate']['commerce']['AutoUpdateRestartRequired']
* node['cpe_softwareupdate']['su']['AllowPreReleaseInstallation']
* node['cpe_softwareupdate']['su']['AutomaticCheckEnabled'] = true
* node['cpe_softwareupdate']['su']['AutomaticDownload'] = true
* node['cpe_softwareupdate']['su']['CatalogURL']
* node['cpe_softwareupdate']['su']['ConfigDataInstall'] = true
* node['cpe_softwareupdate']['su']['CriticalUpdateInstall'] = true

Usage
-----
The profile will manage the `com.apple.SoftwareUpdate` preference domain.

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
