module Fog
  module Compute
    class Vsphere
      class Real
        def vm_destroy_nic(options = {})
          raise ArgumentError, "instance_uuid is a required parameter" unless options.has_key? 'instance_uuid'
          raise ArgumentError, "nic_key is a required parameter" unless options.has_key? 'nic_key'

          vm_ref = get_vm_ref(options['instance_uuid'])
          nic = vm_ref.config.hardware.device.find{|d| d.key == options['nic_key'] && d.is_a?(RbVmomi::VIM::VirtualEthernetCard)}
          device_config_spec = RbVmomi::VIM::VirtualDeviceConfigSpec(
            :operation => :remove,
            :fileOperation => :destroy,
            :device => nic
          )
          hardware_spec={:deviceChange => [device_config_spec]}
          vm_reconfig_hardware('instance_uuid' => options['instance_uuid'], 'hardware_spec' => hardware_spec )
        end
      end

      class Mock
        def vm_reconfig_disk(options = {})
          raise ArgumentError, "instance_uuid is a required parameter" unless options.has_key? 'instance_uuid'
          raise ArgumentError, "nic_key is a required parameter" unless options.has_key? 'nic_key'

          hardware_spec={}
          vm_reconfig_hardware('instance_uuid' => options['instance_uuid'], 'hardware_spec' => hardware_spec )
        end
      end
    end
  end
end
