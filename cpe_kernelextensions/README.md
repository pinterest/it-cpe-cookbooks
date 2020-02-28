cpe_kernelextensions Cookbook
=========================
Install a profile to manage the kernel extensions.

Requirements
------------
macOS

Attributes
----------
* node['cpe_kernelextensions']
* node['cpe_kernelextensions']['AllowUserOverrides']
* node['cpe_kernelextensions']['AllowedTeamIdentifiers']
* node['cpe_kernelextensions']['AllowedKernelExtensions']

Usage
-----
The profile will manage the `com.apple.syspolicy.kernel-extension-policy` preference domain.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`

The profile delivers a payload of all keys in `node['cpe_kernelextensions']` that are non-nil values.  The provided defaults are nil, so that no profile is installed by default.

You can add any arbitrary keys to `node['cpe_kernelextensions']` to have them added to your profile.  As long as the values are not nil and create a valid profile, this cookbook will install and manage them.

    # Allow user overrides
    node.default['cpe_kernelextensions']['AllowUserOverrides'] = true
    # List of allowed Team IDs
    # Google
    node.default['cpe_kernelextensions']['AllowedTeamIdentifiers'] = [
      'EQHXZ8M8AV',
    ]
    # Only allow Santa
    # List of allowed Kernel Extensions
    node.default['cpe_kernelextensions']['AllowedKernelExtensions'] = {
      'EQHXZ8M8AV' => [
        'com.google.santa-driver',
      ]
    }
