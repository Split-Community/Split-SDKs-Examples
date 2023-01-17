package main 

import "fmt"
import (
    "github.com/splitio/go-client/splitio/client"
    "github.com/splitio/go-toolkit/logging"
    "github.com/splitio/go-client/splitio/conf")

func main() {
  cfg := conf.Default()
  cfg.LoggerConfig.LogLevel = logging.LevelDebug
  cfg.SplitFile = "/Users/bilalal-shahwany/Desktop/Projects/Go/GoSDK/split.yaml"
  factory, err := client.NewSplitFactory("localhost", cfg)
  client := factory.Client()
  err = client.BlockUntilReady(5)
  if err != nil {
        fmt.Printf("SDK init error: %s\n", err)
        return
  }
  treatment := client.Treatment("key2", "direct_to_pdp", nil)
  fmt.Printf("\n\nTreatment "+treatment+"\n\n")
}