cpe_windows_task Cookbook
=========================
This is a cookbook that will manage all of the Windows tasks used with
chef.

Requirements
------------
Windows


Attributes
----------
* node['cpe_windows_task']
* node['cpe_windows_task']['prefix']

Usage
-----
Include this recipe and add any windows_task items in the format shdown in the
example below.

**Note:** Ensure that you override the default value of `node['cpe_windows_task']['prefix']`
in a recipe (like a custom company_init). If you do not do this, it will assume 
a label prefix of `com.Pinterest.chef`.

**THIS MUST GO IN A RECIPE. DO NOT PUT THIS IN ATTRIBUTES, OR IT MAY CAUSE PAIN
AND SUFFERING FOR YOUR FLEET!**

If you are creating a new task, in your recipe add a key to
node.default['cpe_windows_task'] that is the name of the label of the task that
you would like to create and the value should be the key found in the windows_task
docs on docs.chef.org

    node.default['cpe_windows_task']['com.pinterest.chef.sal'] = {
    'command' => 'gosal.exe --config config.json',
    'run_level' => :highest,
    'frequency' => :hourly,
    }

If you are porting a task over from the traditional way of managing tasks you can
used to old label name and we will take care of pre-pending com.Pinterest.chef,
and delete the old task for you. Also this shows how to add a key to a set of
tasks

    {
      'sal' => {
        'command' => 'cmd /c "gosal.exe --config config.json"',
      },
      'chef-client' => {
        'command' => 'cmd /c "C:\opscode\chef\embedded\bin\ruby.exe C:\opscode\chef\bin\chef-client -L C:\chef\chef-client.log -c C:\chef\client.rb"',
        'run_level' => :highest,
    }.each do |k, v|
      node.default['cpe_windows_task'][k] = v
      node.default['cpe_windows_task'][k]['frequency'] = :hourly
    end
