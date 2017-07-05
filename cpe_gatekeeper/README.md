cpe_gatekeeper Cookbook
=========================
Install a profile to disable System Preference Panes.

Requirements
------------
Mac OS X

Attributes
----------
* node['cpe_gatekeeper']
* node['cpe_gatekeeper']['control']['EnableAssessment']
* node['cpe_gatekeeper']['control']['AllowIdentifiedDevelopers']
* node['cpe_gatekeeper']['managed']['DisableOverride']

Usage
-----
The profile will manage the `com.apple.systempolicy.control` _and_ `com.apple.systempolicy.managed` preference domains.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`

The profile delivers a payload of all keys in `node['cpe_gatekeeper']` that are non-nil values.

    # Enable Assessment of Applications
    node.default['cpe_gatekeeper']['control']['EnableAssessment'] = true
    # Allow Identified Developers
    node.default['cpe_gatekeeper']['control']['AllowIdentifiedDevelopers'] = true
    # Force Gatekeeper Configuration
    node.default['cpe_gatekeeper']['managed']['DisableOverride'] = true
