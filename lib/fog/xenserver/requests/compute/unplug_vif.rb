module Fog
  module Compute
    class XenServer
      class Real
        def unplug_vif( ref, extra_args = {})
          @connection.request({:parser => Fog::Parsers::XenServer::Base.new, :method => 'VIF.unplug'}, ref)
        end
      end

      class Mock
        def unplug_vif()
          Fog::Mock.not_implemented
        end

      end
    end
  end
end
