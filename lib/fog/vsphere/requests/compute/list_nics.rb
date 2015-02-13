module Fog
  module Compute
    class Vsphere
      class Real
        def list_nics(options = { })
          options[:folder] ||= options['folder']
          search_filter = { :uuid => options['instance_uuid'], 'vmSearch' => true, 'instanceUuid' => true }
          vm_mob_ref = @connection.searchIndex.FindAllByUuid(search_filter).first
          nics = vm_mob_ref.config.hardware.device.grep(RbVmomi::VIM::VirtualVmxnet3) + vm_mob_ref.config.hardware.device.grep(RbVmomi::VIM::VirtualE1000)
          return nics
        end
      end

      class Mock
        def list_nics(filters = { })
        end
      end
    end
  end
end
