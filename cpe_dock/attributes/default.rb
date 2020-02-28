#
# Cookbook:: cpe_dock
# Attributes:: default
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright:: (c) 2018-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

default['cpe_dock'] = {
  'static-apps' => nil,
  'static-others' => nil,
  'tilesize' => nil,
  'orientation' => nil,
  'mineffect' => nil,
  'minimize-to-application' => nil,
  'launchanim' => nil,
  'autohide' => nil,
  'show-process-indicators' => nil,
  'static-only' => nil,
  'contents-immutable' => nil,
  'launchanim-immutable' => nil,
  'magnify-immutable' => nil,
  'magsize-immutable' => nil,
  'mineffect-immutable' => nil,
  'minimize-to-application-immutable' => nil,
  'position-immutable' => nil,
  'show-process-indicators-immutable' => nil,
  'magnification' => nil,
  'size-immutable' => nil,
}
