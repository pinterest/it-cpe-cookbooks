cpe_dock Cookbook
=========================
Install a profile to manage the dock.

Requirements
------------
macOSs

Attributes
----------
* node['cpe_dock']
* node['cpe_dock']['static-apps']
* node['cpe_dock']['static-others']
* node['cpe_dock']['tilesize']
* node['cpe_dock']['orientation']
* node['cpe_dock']['mineffect']
* node['cpe_dock']['minimize-to-application']
* node['cpe_dock']['launchanim']
* node['cpe_dock']['autohide']
* node['cpe_dock']['show-process-indicators']
* node['cpe_dock']['static-only']
* node['cpe_dock']['contents-immutable']
* node['cpe_dock']['launchanim-immutable']
* node['cpe_dock']['magnify-immutable']
* node['cpe_dock']['magsize-immutable']
* node['cpe_dock']['mineffect-immutable']
* node['cpe_dock']['minimize-to-application-immutable']
* node['cpe_dock']['position-immutable']
* node['cpe_dock']['show-process-indicators-immutable']
* node['cpe_dock']['magnification']
* node['cpe_dock']['size-immutable']

Usage
-----
The profile will manage the `com.apple.dock` preference domain.

The profile's organization key defaults to `Pinterest` unless `node['organization']` is
configured in your company's custom init recipe. The profile will also use
whichever prefix is set in node['cpe_profiles']['prefix'], which defaults to `com.facebook.chef`

The profile delivers a payload of all keys in `node['cpe_dock']` that are non-nil values.  The provided defaults are nil, so that no profile is installed by default.

You can add any arbitrary keys to `node['cpe_dock']` to have them added to your profile.  As long as the values are not nil and create a valid profile, this cookbook will install and manage them.

  # Add App Store and MSC to the dock
  node.default['cpe_dock']['static-apps'] = [
    {
      'mcx_typehint' => 1,
      'tile-data' => {
        'file-data' => {
          '_CFURLString' => '/Applications/App Store.app',
          '_CFURLStringType' => 0,
        },
        'file-label' => 'App Store',
      },
      'tile-type' => 'file-tile',
    },
    {
      'mcx_typehint' => 1,
      'tile-data' => {
        'file-data' => {
          '_CFURLString' => '/Applications/Managed Software Center.app',
          '_CFURLStringType' => 0,
        },
        'file-label' => 'Managed Software Center',
      },
      'tile-type' => 'file-tile',
    },
  ]

  # Add a folder link to /Applications
  node.default['cpe_dock']['static-others'] = [
    {
      'mcx_typehint' => 2,
      'tile-data' => {
        'file-data' => {
          '_CFURLString' => '/Applications',
          '_CFURLStringType' => 0,
        },
        'file-label' => 'Applications',
        'file-type' => 2,
      },
      'tile-type' => 'directory-tile',
    },
  ]

  # Various other settings you can figure out
  node.default['cpe_dock']['tilesize'] = 64
  node.default['cpe_dock']['orientation'] = 'bottom'
  node.default['cpe_dock']['mineffect'] = 'genie'
  node.default['cpe_dock']['minimize-to-application'] = false
  node.default['cpe_dock']['launchanim'] = true
  node.default['cpe_dock']['autohide'] = false
  node.default['cpe_dock']['show-process-indicators'] = true
  node.default['cpe_dock']['static-only'] = true
  node.default['cpe_dock']['contents-immutable'] = false
  node.default['cpe_dock']['launchanim-immutable'] = false
  node.default['cpe_dock']['magnify-immutable'] = false
  node.default['cpe_dock']['magsize-immutable'] = false
  node.default['cpe_dock']['mineffect-immutable'] = false
  node.default['cpe_dock']['minimize-to-application-immutable'] = false
  node.default['cpe_dock']['position-immutable'] = false
  node.default['cpe_dock']['show-process-indicators-immutable'] = false
  node.default['cpe_dock']['magnification'] = false
  node.default['cpe_dock']['size-immutable'] = false
