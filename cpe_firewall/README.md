cpe_firewall Cookbook
========================
Install a profile to manage firewall settings.

Requirements
------------
* macOS 10.12 and higher

Attributes
----------
* node['cpe_firewall']
* node['cpe_firewall']['EnableFirewall']
* node['cpe_firewall']['BlockAllIncoming']
* node['cpe_firewall']['EnableStealthMode']
* node['cpe_firewall']['Applications']

Usage
-----
The profile will manage the `com.apple.security.firewall` preference domain.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`

The profile delivers a payload for the above keys in `node['cpe_firewall']`.  The three provided have a sane default, which can be overridden in another recipe if desired.

For example, you could tweak the above values

    node.default['cpe_firewall']['EnableFirewall'] = true
    node.default['cpe_firewall']['BlockAllIncoming'] = true
    node.default['cpe_firewall']['EnableStealthMode'] = true
    node.default['cpe_firewall']['Applications'] = [
      {
        'BundleID' => 'com.apple.appstore',
        'Allowed' => true,
      },
      {
        'BundleID' => 'com.apple.AirPlayUIAgent',
        'Allowed' => false,
      },
    ]
