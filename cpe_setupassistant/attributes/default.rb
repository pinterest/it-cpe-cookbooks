#
# Cookbook Name:: cpe_setupassistant
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

# Disable iCloud and SetupAssistant
default['cpe_setupassistant']['DidSeeCloudSetup'] = nil
default['cpe_setupassistant']['DidSeeSiriSetup'] = nil
default['cpe_setupassistant']['LastSeenBuddyBuildVersion'] = nil
default['cpe_setupassistant']['LastSeenCloudProductVersion'] = nil
default['cpe_setupassistant']['RunNonInteractive'] = nil
