cpe_timemachine Cookbook
=========================
Install a profile to manage Apple Remote Desktop Application settings.

Requirements
------------
Mac OS X

Attributes
----------
* node['cpe_timemachine']
* node['cpe_timemachine']['mcx']['AutoBackup']
* node['cpe_timemachine']['mcx']['BackupAllVolumes']
* node['cpe_timemachine']['mcx']['BackupDestURL']
* node['cpe_timemachine']['mcx']['BackupSkipSys']
* node['cpe_timemachine']['mcx']['BackupSizeMB']
* node['cpe_timemachine']['mcx']['MobileBackups']
* node['cpe_timemachine']['std']['AlwaysShowDeletedBackupsWarning']
* node['cpe_timemachine']['std']['AutoBackup']
* node['cpe_timemachine']['std']['DoNotOfferNewDisksForBackup']
* node['cpe_timemachine']['std']['ExcludeByPath']
* node['cpe_timemachine']['std']['MaxSize']
* node['cpe_timemachine']['std']['RequiresACPower']
* node['cpe_timemachine']['std']['SkipPaths']
* node['cpe_timemachine']['std']['SkipSystemFiles']

Usage
-----
The profile will manage the `com.apple.MCX.TimeMachine` and the `com.apple.TimeMachine` preference domains.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`

The profile delivers a payload of all keys in `node['cpe_timemachine']` that are non-nil values.  The six provided keys are nil, so that no profile is installed by default.

You can add any arbitrary keys to `node['cpe_timemachine']` to have them added to your profile.  As long as the values are not nil and create a valid profile, this cookbook will install and manage them.

The most common use case is for service machines with Apple Remote Desktop installed.

    # Disable Time Machine
    node.default['cpe_timemachine']['mcx']['AutoBackup'] = false
    node.default['cpe_timemachine']['mcx']['BackupAllVolumes'] = false
    node.default['cpe_timemachine']['mcx']['BackupDestURL'] = 'fakeurl://fakeplace'
    node.default['cpe_timemachine']['mcx']['BackupSkipSys'] = true
    # 0 is unlimited for BackupSizeMB
    node.default['cpe_timemachine']['mcx']['BackupSizeMB'] = 1
    node.default['cpe_timemachine']['mcx']['MobileBackups'] = false

    # Time Machine non MC X
    node.default['cpe_timemachine']['std']['AlwaysShowDeletedBackupsWarning'] = false
    node.default['cpe_timemachine']['std']['AutoBackup'] = false
    node.default['cpe_timemachine']['std']['DoNotOfferNewDisksForBackup'] = false
    node.default['cpe_timemachine']['std']['ExcludeByPath'] = []
    node.default['cpe_timemachine']['std']['MaxSize'] = 1
    node.default['cpe_timemachine']['std']['RequiresACPower'] = true
    node.default['cpe_timemachine']['std']['SkipPaths'] = []
    node.default['cpe_timemachine']['std']['SkipSystemFiles'] = true
