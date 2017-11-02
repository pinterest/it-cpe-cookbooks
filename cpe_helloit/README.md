cpe_helloit Cookbook
========================
Install a profile to manage Hello-IT settings.

Requirements
------------
* Hello-IT

Attributes
----------
* node['cpe_helloit']
* node['cpe_helloit']['install']
* node['cpe_helloit']['uninstall']
* node['cpe_helloit']['profile']
* node['cpe_helloit']['manage_la']
* node['cpe_helloit']['pkgs']
* node['cpe_helloit']['prefs']['content']

Notes
-----
By default, this cookbook will use `cpe_remote` to install Hello-IT. If you do not have this configured, your chef run may fail.

If you would like to customize the menubar icons, you will need to modify the contents in `cpe_helloit/files/default/helloit/CustomStatusBarIcon`

Requirements
-----
This cookbook depends on the following cookbooks
* cpe_launchd
* cpe_profiles
* cpe_remote

The cookbooks are offered by Facebook in the [IT-CPE](https://github.com/facebook/IT-CPE) repository.

Usage
-----
By default, this cookbook will not install Hello-IT preferences or files.

The profile will manage the `com.github.ygini.Hello-IT` preference domain.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`

The profile delivers a payload for the above keys in `node['cpe_helloit']`.  The three provided have a sane default, which can be overridden in another recipe if desired.

For example, you could tweak the below values

    node.default['cpe_helloit']['content'] = [
      {
        'functionIdentifier' => 'public.title',
        'settings' = {
          'title' => 'Example Title'
          },
      },
    ]
