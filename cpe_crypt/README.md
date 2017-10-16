cpe_crypt Cookbook
========================
Installs and managed Crypt.


Attributes
----------
* node['cpe_crypt']
* node['cpe_crypt']['install']
* node['cpe_crypt']['uninstall']
* node['cpe_crypt']['profile']
* node['cpe_crypt']['manage_authdb']
* node['cpe_crypt']['manage_ld']
* node['cpe_crypt']['pkgs']
* node['cpe_crypt']['prefs']['ServerURL']
* node['cpe_crypt']['prefs']['SkipUsers']
* node['cpe_crypt']['prefs']['RemovePlist']
* node['cpe_crypt']['prefs']['RotateUsedKey']

Notes
-----
By default, this cookbook will use `cpe_remote` to install Crypt. If you do not have this configured, your chef run may fail.

Notes on Crypt
-----
As of Crypt 3, Crypt only supports 10.12 and higher. If you have devices on Operating Systems below this threshold, you will need to supply your own logic to handle the installations.

Requirements
-----
This cookbook depends on the following cookbooks
* cpe_launchd
* cpe_profiles
* cpe_remote

The cookbooks are offered by Facebook in the [IT-CPE](https://github.com/facebook/IT-CPE) repository.

Usage
-----
By default, this cookbook will not install Crypt preferences or files.

The profile will manage the `com.grahamgilbert.crypt` preference domain.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`

The profile delivers a payload for the above keys in `node['cpe_crypt']`.  The three provided have a sane default, which can be overridden in another recipe if desired.

For example, you could tweak the above values

    node.default['cpe_crypt']['install'] = true
    node.default['cpe_crypt']['prefs']['ServerURL'] =
      'https://crypt.somewhere.com'
    node.default['cpe_crypt']['prefs']['SkipUsers'] = [
      'supersecretadmin',
      'noreallysupersecretadmin'
    ]
    node.default['cpe_crypt']['prefs']['RemovePlist'] = false
    node.default['cpe_crypt']['prefs']['RotateUsedKey'] = false
    node.default['cpe_crypt']['pkg'] = {
      'app' => 'crypt',
      'checksum' =>
        '1582e974820a5b27cfe462521cb0d4802319224753f3d6417ee23fff9333872a',
      'receipt' => 'com.grahamgilbert.Crypt',
      'version' => '3.0.0.109',
    }
