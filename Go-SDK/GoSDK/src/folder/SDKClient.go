package main 

import "fmt"
import (
	"github.com/splitio/go-client/splitio/conf"
	"time"
	"folder/mySplit"
)

func main() {
  cfg := conf.Default()
  cfg.BlockUntilReady = 10
  mySplit.Initialize("xxxxxxx", cfg)

  treatment := mySplit.SendSplitTreatment("testing112", "clients_on", nil)
  if treatment == "on" {
	fmt.Printf("\n\nTreatment on")
  } else if treatment == "off" {
	fmt.Printf("\n\nTreatment off")
  } else {
	fmt.Printf("\n\nSDK not ready")
  }
  fmt.Printf("\n\n delays... \n\n")
  time.Sleep(30000 * time.Millisecond)
  mySplit.Destroy()
}