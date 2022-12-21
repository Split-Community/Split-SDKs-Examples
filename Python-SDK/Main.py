import logging
import MySplit
from time import sleep
import json

logging.basicConfig(filename='split.log',level=logging.DEBUG)

try:
    attributes=None
    attributes = dict()
    attributes['country'] = 'US'
    
    split = MySplit.MySplit('82fbrnes69f0okest867u4j6771huom3332r')
    #treatment = split.getSplitTreatment('testing554', 'sample_feature', attributes)
    treatment = split.getSplitTreatment(clientId="tin.tran+1", splitName="TestSlit", attributes=None)
  #  treatment = "on"
    print("treatment: "+treatment)

# Getting treatment with Dynamic Configuration
    #treatment = split.getSplitTreatmentWithConfig(clientId="tin.tran+1", splitName="TestSlit", attributes=None)
    print("treatment: "+treatment[0])    
#    config=json.loads(treatment[1])
    
# Looping through configuration Keys
#    for key in config:
#        print("Key name: "+key+", value: "+config[key])
        
    
    if not split.sendTrack("testing554", "account", "conversion"):
        print("failed to send track event")
        split.destroy()
    sleep(60)
    
except ValueError:
    print("value error")
    quit()

