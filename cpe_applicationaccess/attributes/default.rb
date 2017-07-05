#
# Cookbook Name:: cpe_applicationaccess
# Attributes:: default
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

default['cpe_applicationaccess'] = {
  # Path Application Whitelist/Blacklist
  'lists' => {
    'pathBlackList' => nil,
    'pathWhiteList' => nil,
    'whiteList' => nil,
  },
  # Application Access Features
  'features' => {
    'allowAutoUnlock' => nil,
    'allowCamera' => nil,
    'allowCloudAddressBook' => nil,
    'allowCloudBTMM' => nil,
    'allowCloudDesktopAndDocuments' => nil,
    'allowCloudDocumentSync' => nil,
    'allowCloudFMM' => nil,
    'allowCloudKeychainSync' => nil,
    'allowCloudMail' => nil,
    'allowCloudCalendar' => nil,
    'allowCloudReminders' => nil,
    'allowCloudBookmarks' => nil,
    'allowCloudNotes' => nil,
    'allowDefinitionLookup' => nil,
    'allowMusicService' => nil,
    'allowSpotlightInternetResults' => nil,
  },
}
