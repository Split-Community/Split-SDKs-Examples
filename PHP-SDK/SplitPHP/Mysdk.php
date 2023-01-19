<?php
require_once 'vendor/autoload.php';
use SplitIO\Sdk;

class MySDK {
    var  $splitClient;
    function __construct($apiKey, $sdkConfig) {
        $splitFactory = Sdk::factory($apiKey, $sdkConfig);
        $this->splitClient = $splitFactory->client();
    }

    function getSplitTreatment($clientId, $splitName) {
        return $this->splitClient->getTreatment($clientId,$splitName);
    }
    
    function getSplitTreatmentWithConfig($clientId, $splitName) {
        return $this->splitClient->getTreatmentWithConfig($clientId,$splitName);
    }
    
    function sendMetric($key, $trafficType, $eventType, $value) {
        return $this->splitClient->track($key, $trafficType, $eventType, $value);
    }
}

?>

