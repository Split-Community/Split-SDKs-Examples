module Main
  require 'splitclient-rb'
   
  options = {
  debug_enabled: true, 
  transport_debug_enabled: true
  }  
  split_factory = SplitIoClient::SplitFactoryBuilder.build("API KEY", options)
    
  split_client = split_factory.client
  begin
    split_client.block_until_ready
  rescue SplitIoClient::SDKBlockerTimeoutExpiredException 
    puts 'SDK is not ready. Decide whether to continue or abort execution'  
  end
    
  attributes = {}
  attributes[:country] = 'US'
  treatment = split_client.get_treatment("12345", "sample_feature", attributes);
  puts "treatment "+treatment
  
  treatmentConfig = split_client.get_treatment_with_config("12345", "sample_feature", attributes);
  puts "treatment: "+treatmentConfig[:treatment] 

  configs = JSON.parse treatmentConfig[:config].gsub('=>', ':')
  
  configs.each do |key, value|
    puts "Key #{key}: "+configs[key]
  end
  
  track_event = split_client.track("12345", "client", "conversion")

  sleep(60)
  split_client.destroy()
end







#  options = {
#  cache_adapter: :redis,
#  mode: :standalone,
#  redis_url: 'redis://127.0.0.1:6379/0'}
