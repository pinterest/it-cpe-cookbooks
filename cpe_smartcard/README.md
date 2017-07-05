cpe_smartcard Cookbook
========================
Install a profile to manage smart cards.


Attributes
----------
* node['cpe_smartcard']
* node['cpe_smartcard']['allowSmartCard']
* node['cpe_smartcard']['checkCertificateTrust']
* node['cpe_smartcard']['oneCardPerUser']
* node['cpe_smartcard']['UserPairing']

Usage
-----
The profile will manage the `com.apple.security.smartcard` preference domain.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`


    node.default['cpe_smartcard']['allowSmartCard'] = true
    node.default['cpe_smartcard']['checkCertificateTrust'] = true
    node.default['cpe_smartcard']['oneCardPerUser'] = true
    node.default['cpe_smartcard']['UserPairing'] = true
