package sample;

import sample.MySplit;

import java.util.Map;
import java.util.HashMap;
import java.util.List;

import io.split.client.api.SplitResult;

public class SplitSDK_Sample {

		
		public static void main(String[] args) {

			try {
				MySplit split = new MySplit("API KEY");
								
				Map<String, Object> attributes = new HashMap<String, Object>();
	            attributes.put("country", "Canada");
				String treatment = split.GetSplitTreatment("bob", "sample_feature", attributes);	            
				System.out.print("Treatment: "+treatment+"\n\n");
				
				SplitResult treatmentWithConfig = split.GetSplitTreatmentWithConfig("bob", "sample_feature", attributes);	            
				System.out.print("Treatment with config: "+treatmentWithConfig+"\n");
				
				HashMap<String, Object> properties = new HashMap<>();
				properties.put("price", 240);
				properties.put("payment", "visa");
				properties.put("shipping", "standard");
				
				if (!split.SendTrackEvent("bob", "account", "conversion", 1, properties)) {
				    System.out.print("\n\nFailed to Send Track Event\n\n");
				}

				
			} catch (Exception e) {
				System.out.print("Exception: "+e.getMessage());
			}
		}

}






/*				String keys[] = treatmentWithConfig.config().substring(1).substring(0, treatmentWithConfig.config().length() - 2).split(",");			
for (int j=0;j<keys.length;j++) {
    String[] keyValue = keys[j].split(":");
    System.out.println("Key: "+keyValue[0]+", Value: "+keyValue[1]);
}
*/				
