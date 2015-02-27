module Fog
  module Compute
    class Vsphere
      class Real
        def create_nic options = { }
          raise ArgumentError.new('Invalid vm') if options['instance_uuid'].nil?
          raise ArgumentError.new('Invalid network') if options['network'].nil?
          vm = get_vm_ref(options['instance_uuid'])
          nic = RbVmomi::VIM::VirtualE1000(
              :backing => RbVmomi::VIM::VirtualEthernetCardNetworkBackingInfo(:deviceName => options['network']),
              :connectable => RbVmomi::VIM::VirtualDeviceConnectInfo(
                  :allowGuestControl => true,
                  :connected => true,
                  :startConnected => true)
          )
          nic[:key]=options['key'] unless options['key'].nil?
          nic[:deviceInfo]= RbVmomi::VIM::VirtualDeviceConnectInfo(:label=>options['lable'],:summary=>options['network']) unless options['label'].nil?
          vm_cfg={:deviceChange=>[{:operation=>:add,:device=>nic}]}
          vm.ReconfigVM_Task(:spec => vm_cfg).wait_for_completion
        end
      end
    end
  end
end

