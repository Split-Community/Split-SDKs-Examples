<?php
namespace SplitIO\Component\Initialization;

use SplitIO\Component\Cache\Pool;
use SplitIO\Component\Common\ServiceProvider;

class CacheTrait
{
    public static function addCache($adapter, array $options)
    {
        switch ($adapter) {
            case 'filesystem':
                $adapter_config = array(
                    'name' => 'filesystem',
                    'options' => array(
                        'path'=> isset($options['filesystem-path']) ? $options['filesystem-path'] : null
                    )
                );
                break;
            case 'predis':
                $adapter_config = array(
                    'name' => 'predis',
                    'options' => array(
                        'options'               => isset($options['predis-options'])
                            ? $options['predis-options'] : null,
                        'parameters'            => isset($options['predis-parameters'])
                            ? $options['predis-parameters'] : null,
                        'sentinels'             => isset($options['predis-sentinels'])
                            ? $options['predis-sentinels'] : null,
                        'clusterNodes'          => isset($options['predis-clusterNodes'])
                            ? $options['predis-clusterNodes'] : null,
                        'distributedStrategy'   => isset($options['predis-distributedStrategy'])
                            ? $options['predis-distributedStrategy'] : null,
                    )
                );
                break;
            case 'redis':
            default:
                $adapter_config = array(
                    'name' => 'redis',
                    'options' => array(
                        'host'      => isset($options['redis-host']) ? $options['redis-host'] : null,
                        'port'      => isset($options['redis-port']) ? $options['redis-port'] : null,
                        'password'  => isset($options['redis-pass']) ? $options['redis-pass'] : null,
                        'timeout'   => isset($options['redis-timeout']) ? $options['redis-timeout'] : null,
                    )
                );
                break;
        }

        ServiceProvider::registerCache(new Pool(array('adapter' => $adapter_config)));
    }
}
