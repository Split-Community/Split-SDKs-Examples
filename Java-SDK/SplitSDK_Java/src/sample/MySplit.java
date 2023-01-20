package sample;

import java.util.List;
import java.util.Map;

import io.split.client.SplitClient;
import io.split.client.SplitClientConfig;
import io.split.client.SplitFactory;
import io.split.client.SplitFactoryBuilder;
import io.split.client.api.SplitResult;

public class MySplit {
	SplitClient client;
	SplitFactory splitFactory;

	MySplit(String APIKey) throws Exception {
		SplitClientConfig config = SplitClientConfig.builder()
				.setBlockUntilReadyTimeout(10000)
				.numThreadsForSegmentFetch(6)
//				.enableDebug()
				.build();
		try {
		    this.splitFactory = SplitFactoryBuilder.build(APIKey, config);
		    
		    this.client = this.splitFactory.client();
		    this.client.blockUntilReady();
			System.out.println("*************After blockUntilReady*********");
		    
		    
		} catch (Exception e) {
			System.out.print("Exception: "+e.getMessage());
		}
	}

	SplitResult GetSplitTreatmentWithConfig(String clientId, String splitName, Map<String, Object> attributes) {
        return this.client.getTreatmentWithConfig(clientId, splitName, attributes);				
	}
	SplitResult GetSplitTreatmentWithConfig(String clientId, String splitName) {
        return this.client.getTreatmentWithConfig(clientId, splitName);				
	}
	String GetSplitTreatment(String clientId, String splitName, Map<String, Object> attributes) {
        return this.client.getTreatment(clientId, splitName, attributes);				
	}
	String GetSplitTreatment(String clientId, String splitName) {
        return this.client.getTreatment(clientId, splitName);				
	}
	boolean SendTrackEvent(String userId, String trackType, String metricName, double metricValue) {
		return this.client.track(userId, trackType, metricName, metricValue);
	}
	boolean SendTrackEvent(String userId, String trackType, String metricName) {
		return this.client.track(userId, trackType, metricName);
	}	
	boolean SendTrackEvent(String userId, String trackType, String metricName, Map<String, Object> properties) {
		return this.client.track(userId, trackType, metricName, properties);
	}	
	boolean SendTrackEvent(String userId, String trackType, String metricName, double metricValue, Map<String, Object> properties) {
		return this.client.track(userId, trackType, metricName, metricValue, properties);
	}	
	List<String> GetSplitNames() {
        return this.splitFactory.manager().splitNames();				
	}

	void Destroy()  {
		this.client.destroy();
	}
	
	protected void finalize ()  {
		this.client.destroy();
	}

}
