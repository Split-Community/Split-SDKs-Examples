require 'splitclient-rb'
options = {
    features_refresh_rate: 1,
    segments_refresh_rate: 1,
    block_until_ready: 10,
    debug_enabled: false,
    logger: Logger.new('./log/splitlog.log'),
    cache_adapter: :memory,
    mode: :standalone,
    debug_enabled: true,
}

factory = SplitIoClient::SplitFactory.new("xxxx", options)
Rails.configuration.split_factory = factory

