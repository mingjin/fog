module Fog
  module Compute
    class Vsphere
      class Real
        def create_nic options = { }
          raise ArgumentError.new('Invalid vm') if options['instance_uuid'].nil?
          raise ArgumentError.new('Invalid network') if options['network'].nil?
          nic = RbVmomi::VIM::VirtualE1000(
              :backing => RbVmomi::VIM::VirtualEthernetCardNetworkBackingInfo(:deviceName => options['network']),
              :connectable => RbVmomi::VIM::VirtualDeviceConnectInfo(
                  :allowGuestControl => true,
                  :connected => true,
                  :startConnected => true)
          )
          nic[:key]=options['key'] unless options['key'].nil?
          nic[:deviceInfo]= RbVmomi::VIM::VirtualDeviceConnectInfo(:label=>options['lable'],:summary=>options['network']) unless options['label'].nil?
          hardware_spec={:deviceChange=>[{:operation=>:add,:device=>nic}]}
          vm_reconfig_hardware('instance_uuid' => options['instance_uuid'], 'hardware_spec' => hardware_spec )
        end
      end
    end
  end
end

