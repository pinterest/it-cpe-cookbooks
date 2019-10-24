#
# Cookbook:: cpe_passwordpolicy
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

default['cpe_passwordpolicy'] = {
  'allowSimple' => nil,
  'forcePIN' => nil,
  'maxFailedAttempts' => nil,
  'maxGracePeriod' => nil,
  'maxInactivity' => nil,
  'maxPINAgeInDays' => nil,
  'minComplexChars' => nil,
  'minLength' => nil,
  'minutesUntilFailedLoginReset' => nil,
  'pinHistory' => nil,
  'requireAlphanumeric' => nil,
}
