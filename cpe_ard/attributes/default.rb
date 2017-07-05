#
# Cookbook Name:: cpe_ard
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

# Disable bluetooth setup assistant for mouse and keyboard
default['cpe_ard']['AdminConsoleAllowsRemoteControl'] = nil
default['cpe_ard']['LoadRemoteManagementMenuExtra'] = nil
