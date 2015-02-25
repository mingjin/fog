module Fog
  module Compute
    class XenServer
      class Real
        def plug_vif( ref, extra_args = {})
          @connection.request({:parser => Fog::Parsers::XenServer::Base.new, :method => 'VIF.plug'}, ref)
        end
      end

      class Mock
        def plug_vif()
          Fog::Mock.not_implemented
        end
      end
    end
  end
end
