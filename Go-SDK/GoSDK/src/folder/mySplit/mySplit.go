package mySplit

import "fmt"
import (
	"github.com/splitio/go-client/splitio/client"
	"github.com/splitio/go-client/splitio/conf"
)

var splitClient *client.SplitClient

func Initialize(apiKey string, config *conf.SplitSdkConfig) string {  
	factory, err := client.NewSplitFactory(apiKey, config)
	if err != nil {
		fmt.Printf("SDK init error: %s\n", err)
		return "SDK init error"
	}
	splitClient = factory.Client()
        err = splitClient.BlockUntilReady(10)
        if err != nil {
             fmt.Printf("SDK timeout: %s\n", err)
             return "SDK init error"
        }
	return "OK"
}

func SendSplitTreatment(clientId string, splitName string, attributes map[string]interface{}) string {
	return splitClient.Treatment(clientId, splitName, nil)
}

func Destroy() {
	splitClient.Destroy()
}