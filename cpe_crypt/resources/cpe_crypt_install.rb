#
# Cookbook Name:: cpe_crypt
# Resource:: cpe_crypt_install
#
# Copyright (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_crypt_install
default_action :install

action :install do
  return unless node['cpe_crypt']['install']
  pkg_info = node['cpe_crypt']['package']

  # Install crypt2
  cpe_remote_pkg 'crypt2' do
    app pkg_info['app']
    checksum pkg_info['checksum']
    receipt pkg_info['receipt']
    version pkg_info['version']
  end
end
