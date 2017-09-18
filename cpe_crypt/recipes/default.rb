#
# Cookbook Name:: cpe_crypt
# Recipe:: default
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

return unless node.macos?

cpe_crypt_authdb 'Apply Crypt authorization db settings'
cpe_crypt_profile 'Apply Crypt profile'
cpe_crypt_install 'Install Crypt package'
cpe_crypt_files 'Manage Crypt files'
cpe_crypt_uninstall 'Uninstall Crypt and remove authorization db settings'
