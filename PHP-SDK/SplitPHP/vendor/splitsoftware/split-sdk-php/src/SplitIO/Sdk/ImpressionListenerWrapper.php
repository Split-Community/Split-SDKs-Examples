<?php

namespace SplitIO\Sdk;

use SplitIO\Sdk\Impressions\Impression;
use SplitIO\Split as SplitApp;

// Declaration of ImpressionListenerWrapper class
class ImpressionListenerWrapper
{
    private $impressionListener = null;

    /**
     * Constructor
     *
     * @param   $impressionListener   ImpressionListener  client's instance of that implements ImpressionListener
     *
     * @return \SplitIO\Sdk\ImpressionListenerWrapper
     */
    public function __construct(ImpressionListener $impressionListener)
    {
        $this->impressionListener = $impressionListener;
    }

    /*
     * Builds the result object to be passed to client for doing custom logic with it.
     *
     * @param   $impression   \SplitIO\Sdk\Impressions\Impression   Impression instance as result of treatment:
     *  $impression['$id']                  =>  string   Identity's id
     *  $impression['feature']              =>  string   Identity's feature
     *  $impression['treatment']            =>  string   Identity's treatment result
     *  $impression['label']                =>  string   Identity's label
     *  $impression['time']                 =>  integer  Identity's time
     *  $impression['changeNumber']         =>  number   Identity's change number
     *  $impression['bucketingKey']         =>  string   Identity's bucketing key
     *
     * @param   $attributes   mixed     It will corresponds to every data that user wants to send.
     *
     * NOTE: A try/catch has been placed here to avoid any issue that could break the Sdk logic.
     */
    public function sendDataToClient(Impression $impression, $attributes)
    {
        try {
            // Builds data to send to client
            $data = array(
                'impression' => $impression,
                'attributes' => $attributes,
                'instance-id' => \SplitIO\getHostIpAddress(),
                'sdk-language-version' => 'php-' . \SplitIO\version()
            );

            // Executes client's custom method
            $this->impressionListener->logImpression($data);
        } catch (\Exception $e) {
            SplitApp::logger()->error('logImpression user\'s method is throwing exceptions');
            SplitApp::logger()->error($e->getMessage());
            SplitApp::logger()->error($e->getTraceAsString());
        }
    }
}
