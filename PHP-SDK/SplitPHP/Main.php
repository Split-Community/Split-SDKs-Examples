<?php
include("Mysdk.php");

# Redis information
$parameters = ['scheme' => 'tcp',
    'host' => 'localhost',
    'port' => 6379,
    'timeout' => 881
    ];

$options = ['prefix' => 'myprefix'];

$sdkConfig = array(
    'cache' => array('adapter' => 'predis',
                     'parameters' => $parameters,
                     'options' => $options
    )
);

$split = new MySDK('API KEY', $sdkConfig);


//for ($i=0; $i<500; $i++)
//{
    $treatment = $split->getSplitTreatment('testing111','clients');   
    echo "\nTreatment ".$treatment;
    
    $result = $split->getSplitTreatmentWithConfig('testing111','clients');
    echo "\nTreatment ".$result['treatment'];
    $config = json_decode($result["config"], true);
    foreach ($config as $key => $value){
        echo "\nKey: ".$value.", value: ".$key;
    }
    
    
    $split->sendMetric('testing'.$i, 'client', 'conversion', 1);
//    sleep(5);
//}

?>

