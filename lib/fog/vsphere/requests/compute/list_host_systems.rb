module Fog
  module Compute
    class Vsphere
      class Real
        def list_host_systems(filters = { })
          datacenter_name = filters[:datacenter]
          # default to show all compute_resources
          only_active = filters[:effective] || false
          compute_resources = raw_compute_resources datacenter_name
          
          compute_resources.collect {|cr| cr.host}.flatten.map do |host_system|
            next if only_active and !is_host_system_active?(host_system)
            host_system_attributes(host_system, datacenter_name)
          end.compact
        end
        
        protected
        
        def is_host_system_active? host_system
          runtime = host_system.runtime
          runtime.connectionState == 'connected' && !runtime.inMaintenanceMode && runtime.standbyMode == 'none' && runtime.powerState == 'poweredOn'
        end

        def host_attributes host, datacenter
          {
            :id                 =>   managed_obj_id(host),
            :name               =>   host.name,
            :totalCpu           =>   host.hardware.cpuInfo.numCpuCores*host.hardware.cpuInfo.hz/(1024*1024), #in MHz
            :totalMemory        =>   host.hardware.memorySize/(1024*1024*1024), #in GB
            :overallCpuUsage    =>   host.summary.quickStats.overallCpuUsage,
            :overallMemoryUsage =>   host.summary.quickStats.overallMemoryUsage,
            :effective           =>   is_host_system_active?(host)
          }
        end

      end
      class Mock
        def list_host_systems(filters = { })
          []
        end
      end
    end
  end
end