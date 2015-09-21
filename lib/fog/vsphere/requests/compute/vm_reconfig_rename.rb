module Fog
  module Compute
    class Vsphere
      class Real
        def vm_reconfig_rename(options = {})
          raise ArgumentError, "name is a required parameter" unless options.has_key? 'name'
          raise ArgumentError, "instance_uuid is a required parameter" unless options.has_key? 'instance_uuid'
          hardware_spec={'name' => options['name']}
          vm_reconfig_hardware('instance_uuid' => options['instance_uuid'], 'hardware_spec' => hardware_spec )
        end
      end

      class Mock
        def vm_reconfig_rename(options = {})
          raise ArgumentError, "memory is a required parameter" unless options.has_key? 'memory'
          raise ArgumentError, "instance_uuid is a required parameter" unless options.has_key? 'instance_uuid'
          hardware_spec={'name' => options['name']}
          vm_reconfig_hardware('instance_uuid' => options['instance_uuid'], 'hardware_spec' => hardware_spec )
        end
      end
    end
  end
end
