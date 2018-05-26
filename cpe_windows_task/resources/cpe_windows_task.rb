#
# Cookbook Name:: cpe_windows_task
# Resource:: cpe_windows_task
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2018-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_windows_task
default_action :run

action :run do
  node['cpe_windows_task'].to_hash.each do |label, task|
    next if label == 'prefix'
    label = process_label(label, task)
    action, task = process_task(label, task)
    windows_task_resource(label, action, task)
  end
end

action :clean_up do
  process_task_labels
  return if node['cpe_windows_task']['__cleanup'].nil?
  node['cpe_windows_task']['__cleanup'].each do |task|
    windows_task_resource(task, 'delete', nil)
  end
end

def process_label(label, task)
  return label if label.start_with?(node['cpe_windows_task']['prefix'])
  # label does have the prefix so now we process
  append_to_cleanup(label)
  label = "#{node['cpe_windows_task']['prefix']}.#{label}"
  node.default['cpe_windows_task'][label] = task
  label
end

def process_task(label, task)
  task['task_name'] = label
  action = task['action'] ? task['action'] : 'create'
  task.delete('action')
  return action, task
end

def append_to_cleanup(label)
  node.default['cpe_windows_task']['__cleanup'] = [] unless
    node['cpe_windows_task']['__cleanup']
  node.default['cpe_windows_task']['__cleanup'].push(label)
end

def windows_task_resource(label, action, task)
  return unless label
  res = Chef::Resource::WindowsTask.new(label, run_context)
  unless task.nil?
    task.to_hash.each do |key, val|
      res.send(key.to_sym, val)
    end
  end
  res.run_action action
  res
end

TASK_DIRS = %w{ C:/Windows/System32/Tasks }
def find_managed_task_labels
  tasks = TASK_DIRS.inject([]) do |results, dir|
    edir = ::File.expand_path(dir)
    entries = Dir.glob(
      "#{edir}/*#{
        Chef::Util::PathHelper.escape_glob(node['cpe_windows_task']['prefix'])
      }*"
    )
    entries.any? ? results << entries : results
  end
  tasks.flatten
end

def process_task_labels
  tasks = find_managed_task_labels
  return if tasks.nil?
  tasks.map! do |full_task_path|
    label = full_task_path.split('/')[-1]
    unless node['cpe_windows_task'].keys.include?(label)
      append_to_cleanup(label)
    end
  end
end
