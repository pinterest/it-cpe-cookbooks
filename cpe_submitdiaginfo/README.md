cpe_submitdiaginfo Cookbook
========================
Install a profile to manage diagnostic information submission settings.


Attributes
----------
* node['cpe_submitdiaginfo']
* node['cpe_submitdiaginfo']['AutoSubmit']

Usage
-----
The profile will manage the `com.apple.SubmitDiagInfo` preference domain.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`

The profile delivers a payload for the above keys in `node['cpe_submitdiaginfo']`.  The three provided have a sane default, which can be overridden in another recipe if desired.

For example, you could tweak the above values
    # Do not submit diagnostic information to Apple.
    node.default['cpe_submitdiaginfo']['AutoSubmit'] = false
