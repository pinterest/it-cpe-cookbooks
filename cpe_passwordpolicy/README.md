cpe_passwordpolicy Cookbook
========================
Install a profile to manage password policy and screen saver settings.


Attributes
----------
* node['cpe_passwordpolicy']
* node['cpe_passwordpolicy']['allowSimple']
* node['cpe_passwordpolicy']['forcePIN']
* node['cpe_passwordpolicy']['maxFailedAttempts']
* node['cpe_passwordpolicy']['maxGracePeriod']
* node['cpe_passwordpolicy']['maxInactivity']
* node['cpe_passwordpolicy']['maxPINAgeInDays']
* node['cpe_passwordpolicy']['minComplexChars']
* node['cpe_passwordpolicy']['minLength']
* node['cpe_passwordpolicy']['minutesUntilFailedLoginReset']
* node['cpe_passwordpolicy']['pinHistory']
* node['cpe_passwordpolicy']['requireAlphanumeric']

Usage
-----
The profile will manage the `com.apple.mobiledevice.passwordpolicy` preference domain.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`


    node.default['cpe_passwordpolicy']['allowSimple'] = true
    node.default['cpe_passwordpolicy']['forcePIN'] = true
    node.default['cpe_passwordpolicy']['maxFailedAttempts'] = 10
    node.default['cpe_passwordpolicy']['maxGracePeriod'] = 0
    node.default['cpe_passwordpolicy']['maxInactivity'] = 0
    node.default['cpe_passwordpolicy']['maxPINAgeInDays'] = 365
    node.default['cpe_passwordpolicy']['minComplexChars'] = 5
    node.default['cpe_passwordpolicy']['minLength'] = 10
    node.default['cpe_passwordpolicy']['minutesUntilFailedLoginReset'] = 10
    node.default['cpe_passwordpolicy']['pinHistory'] = 100
    node.default['cpe_passwordpolicy']['requireAlphanumeric'] = true
