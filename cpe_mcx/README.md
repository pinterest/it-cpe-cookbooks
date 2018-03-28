cpe_mcx Cookbook
========================
Install a profile to manage MC X settings.


Attributes
----------
* node['cpe_mcx']
* node['cpe_mcx']['forceInternetSharingOff']

Usage
-----
The profile will manage the `com.apple.mcx` preference domain via MC X Set-Once.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`

The profile delivers a payload for the above keys in `node['cpe_mcx']`.  The three provided have a sane default, which can be overridden in another recipe if desired.

For example, you could tweak the above values

    node.default['cpe_mcx']['forceInternetSharingOff'] = true
