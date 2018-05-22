cpe_8021x Cookbook
=========================
Install a profile to manage the 802.1x settings.

Requirements
------------
Mac OS X

Attributes
----------
* node['cpe_8021x']
* node['cpe_8021x']['ethernet']['AutoJoin']
* node['cpe_8021x']['wifi']['AutoJoin']

Usage
-----
The profile will manage the `com.apple.firstactiveethernet.managed` or `com.apple.globalethernet.managed` and the `com.apple.wifi.managed` preference domains.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`

The profile delivers a payload of all keys in `node['cpe_8021x']` that are non-nil values.  The six provided keys are nil, so that no profile is installed by default.

You can add any arbitrary keys to `node['cpe_8021x']` to have them added to your profile.  As long as the values are not nil and create a valid profile, this cookbook will install and manage them.

    # Setup EAP-TLS (Global Ethernet)
    node.default['cpe_8021x']['ethernet']['AutoJoin'] = true
    node.default['cpe_8021x']['ethernet']['PayloadType'] =
      'com.apple.globalethernet.managed'
    node.default['cpe_8021x']['ethernet']['PayloadCertificateUUID1'] =
      '6416f5be-64a0-4f55-a99e-a50290947207'
    node.default['cpe_8021x']['ethernet']['EAPClientConfiguration'] = {
      'AcceptEAPTypes' => [
        13,
      ],
      'TLSAllowTrustExceptions' => false,
      'TLSCertificateIsRequired' => true,
      'TLSTrustedServerNames' => [
        'radius.corp.pinadmin.com',
        'sfo-radius.corp.pinadmin.com',
      ],
      'Interface' => 'AnyEthernet',
    }

    # Setup EAP-TLS (First Active Ethernet)
    node.default['cpe_8021x']['ethernet']['AutoJoin'] = true
    node.default['cpe_8021x']['ethernet']['PayloadType'] =
      'com.apple.firstactiveethernet.managed'
    node.default['cpe_8021x']['ethernet']['PayloadCertificateUUID1'] =
      '6416f5be-64a0-4f55-a99e-a50290947207'
    node.default['cpe_8021x']['ethernet']['EAPClientConfiguration'] = {
      'AcceptEAPTypes' => [
        13,
      ],
      'TLSAllowTrustExceptions' => false,
      'TLSCertificateIsRequired' => true,
      'TLSTrustedServerNames' => [
        'radius.corp.pinadmin.com',
        'sfo-radius.corp.pinadmin.com',
      ],
      'Interface' => 'FirstActiveEthernet',
    }

    # Setup EAP-TLS (Wifi)
    node.default['cpe_8021x']['wifi']['AutoJoin'] = true
