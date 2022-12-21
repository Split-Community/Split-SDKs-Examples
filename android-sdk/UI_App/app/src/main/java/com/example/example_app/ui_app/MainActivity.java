package com.example.bilalal_shahwany.ui_app;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.Button;
import android.view.View;
import io.split.android.client.SplitResult;
import io.split.android.client.api.Key;

import java.util.Iterator;
import java.util.Map;
import com.example.bilalal_shahwany.ui_app.SplitSDK;
import com.google.gson.Gson;

public class MainActivity extends AppCompatActivity {

    SplitSDK sdkclient;
    Button b1;
    String apikey = "API KEY";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        String matchingKey = "0304A695";
        String bucketingKey = null;
        Key k = new Key(matchingKey, bucketingKey);
        try {
            Log.d("myTag", "Creating SplitFactory object");
            sdkclient= new SplitSDK(apikey, k, getApplicationContext());
        } catch (Exception e) {
            System.out.print("Exception: "+e.getMessage());
        }

        b1 = (Button)this.findViewById(R.id.button);
        b1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                try {
                    Log.d("myTag", "click" + sdkclient.isReady);
                    if (sdkclient.isReady==true) {
                        String treatment = sdkclient.GetSplitTreatment("clients");
                        Log.d("myTag", "treatment: "+treatment);

                        SplitResult result = sdkclient.GetSplitTreatmentWithConfig("clients", null);
                        Log.d("myTag", "treatment: "+result.treatment());
                        Gson gson = new Gson();
                        Map map = gson.fromJson(result.config(), Map.class);
                        Iterator it = map.entrySet().iterator();
                        while (it.hasNext()) {
                            Map.Entry pair = (Map.Entry)it.next();
                            System.out.println(pair.getKey() + " = " + pair.getValue());
                            it.remove(); // avoids a ConcurrentModificationException
                        }


                        sdkclient.SendTrackEvent("account", "conversion");
//                        client.Destroy();
                    } else Log.d("myTag", "SDK not ready: " + sdkclient.isReady);

                } catch (Exception e) {
                    System.out.print("Exception: "+e.getMessage());
                }
            }
        });



    }



}
