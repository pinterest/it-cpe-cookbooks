cpe_loginwindow Cookbook
=========================
Install a profile to manage the loginwindow.

Requirements
------------
macOSs

Attributes
----------
* node['cpe_loginwindow']
* node['cpe_loginwindow']['LoginwindowText']

Usage
-----
The profile will manage the `com.apple.loginwindow` preference domain.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`

The profile delivers a payload of all keys in `node['cpe_loginwindow']` that are non-nil values.  The provided defaults are nil, so that no profile is installed by default.

You can add any arbitrary keys to `node['cpe_loginwindow']` to have them added to your profile.  As long as the values are not nil and create a valid profile, this cookbook will install and manage them.

    # Add Property of tag to bottom of Loginwindow
    node.default['cpe_loginwindow']['LoginwindowText'] = 'Property of Pinterest'

If you wanted to have some a multi-line, dynamic LoginwindowText, you could do something like the following:

    # Add Property of tag to bottom of Loginwindow, a new line (0x0d.chr), and
    # show the hostname of the machine dynamically.
    node.default['cpe_loginwindow']['LoginwindowText'] =
      'Property of Pinterest' + 0x0D.chr + "Machine Name: #{node['hostname']}"
