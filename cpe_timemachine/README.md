cpe_timemachine Cookbook
=========================
Install a profile to manage Apple Remote Desktop Application settings.

Requirements
------------
Mac OS X

Attributes
----------
* node['cpe_timemachine']
* node['cpe_timemachine']['AutoBackup']
* node['cpe_timemachine']['BackupAllVolumes']
* node['cpe_timemachine']['BackupDestURL']
* node['cpe_timemachine']['BackupSkipSys']
* node['cpe_timemachine']['BackupSizeMB']
* node['cpe_timemachine']['MobileBackups']

Usage
-----
The profile will manage the `com.apple.MCX.TimeMachine` preference domain.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`

The profile delivers a payload of all keys in `node['cpe_timemachine']` that are non-nil values.  The six provided keys are nil, so that no profile is installed by default.

You can add any arbitrary keys to `node['cpe_timemachine']` to have them added to your profile.  As long as the values are not nil and create a valid profile, this cookbook will install and manage them.

The most common use case is for service machines with Apple Remote Desktop installed.

    # Disable Time Machine
    node.default['cpe_timemachine']['AutoBackup'] = false
    node.default['cpe_timemachine']['BackupAllVolumes'] = false
    node.default['cpe_timemachine']['BackupDestURL'] = 'fakeurl://fakeplace'
    node.default['cpe_timemachine']['BackupSkipSys'] = true
    # 0 is unlimited for BackupSizeMB
    node.default['cpe_timemachine']['BackupSizeMB'] = 1
    node.default['cpe_timemachine']['MobileBackups'] = false
