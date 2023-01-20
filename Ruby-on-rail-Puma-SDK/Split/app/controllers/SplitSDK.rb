require 'singleton'
class SplitSDK
    attr_writer :local_split_client
    include Singleton
    def initialize()
        puts "insitiaslizig.."
        options = {block_until_ready: 10}
        #        split_factory = SplitIoClient::SplitFactoryBuilder.build("xxxxx", options)
        @local_split_client = Rails.configuration.split_factory.client
        begin
            @local_split_client.block_until_ready
        rescue SplitIoClient::SDKBlockerTimeoutExpiredException
          puts 'SDK is not ready. Decide whether to continue or abort execution'
        end
    end
    def getTreatment(clientName, envName)
        return @local_split_client.get_treatment(clientName, envName)
    end
end
