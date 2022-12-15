from splitio import get_factory
from splitio.exceptions import TimeoutException
import logging

class MySplit:
    def __init__(self, APIKey):
        try:
            factory = get_factory(APIKey, config={'impressionsRefreshRate' : 5, 'eventsPushRate': 5})
            factory.block_until_ready(5)
            self.splitClient = factory.client()
        except Exception:
            print("an exception")

    def getSplitTreatment(self, clientId, splitName, attributes):
        if attributes==None:
            return self.splitClient.get_treatment(clientId, splitName)
        else:
            return self.splitClient.get_treatment(clientId, splitName, attributes)

    def getSplitTreatmentWithConfig(self, clientId, splitName, attributes):
        if attributes==None:
            return self.splitClient.get_treatment_with_config(clientId, splitName)
        else:
            return self.splitClient.get_treatment_with_config(clientId, splitName, attributes)

    def sendTrack(self, clientId, trackType, eventType):
        return self.splitClient.track(clientId, trackType, eventType)
    
    def __del__(self):
        self.splitClient.destroy()

    def destroy(self):
        self.splitClient.destroy()

