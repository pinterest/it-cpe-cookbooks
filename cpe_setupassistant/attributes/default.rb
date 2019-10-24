#
# Cookbook:: cpe_setupassistant
# Attributes:: default
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright:: (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

# Disable iCloud and SetupAssistant

default['cpe_setupassistant']['once']['DidSeeAppearanceSetup'] = nil
default['cpe_setupassistant']['once']['DidSeeApplePaySetup'] = nil
default['cpe_setupassistant']['once']['DidSeeAvatarSetup'] = nil
default['cpe_setupassistant']['once']['DidSeeCloudSetup'] = nil
default['cpe_setupassistant']['once']['DidSeePrivacy'] = nil
default['cpe_setupassistant']['once']['DidSeeSiriSetup'] = nil
default['cpe_setupassistant']['once']['DidSeeSyncSetup'] = nil
default['cpe_setupassistant']['once']['DidSeeSyncSetup2'] = nil
default['cpe_setupassistant']['once']['DidSeeTouchIDSetup'] = nil
default['cpe_setupassistant']['once']['DidSeeTrueTonePrivacy'] = nil
default['cpe_setupassistant']['once']['DidSeeiCloudLoginForStorageServices'] =
  nil
default['cpe_setupassistant']['once']['LastPreLoginTasksPerformedBuild'] = nil
default['cpe_setupassistant']['once']['LastPreLoginTasksPerformedVersion'] = nil
default['cpe_setupassistant']['once']['LastPrivacyBundleVersion'] = nil
default['cpe_setupassistant']['once']['LastSeenBuddyBuildVersion'] = nil
default['cpe_setupassistant']['once']['LastSeenCloudProductVersion'] = nil
default['cpe_setupassistant']['once']['MiniBuddyLaunchReason'] = nil
default['cpe_setupassistant']['once']['MiniBuddyLaunchedPostMigration'] = nil
default['cpe_setupassistant']['once']['MiniBuddyShouldLaunchToResumeSetup'] =
  nil
default['cpe_setupassistant']['once']['NSAddServicesToContextMenus'] = nil
default['cpe_setupassistant']['once']['PreviousBuildVersion'] = nil
default['cpe_setupassistant']['once']['PreviousSystemVersion'] = nil
default['cpe_setupassistant']['once']['RunNonInteractive'] = nil
default['cpe_setupassistant']['once']['SkipFirstLoginOptimization'] = nil

default['cpe_setupassistant']['managed']['SkipCloudSetup'] = nil
default['cpe_setupassistant']['managed']['SkipSiriSetup'] = nil
default['cpe_setupassistant']['managed']['SkipPrivacySetup'] = nil
default['cpe_setupassistant']['managed']['SkipiCloudStorageSetup'] = nil
