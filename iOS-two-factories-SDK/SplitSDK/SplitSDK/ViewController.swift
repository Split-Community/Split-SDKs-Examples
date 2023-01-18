//
//  ViewController.swift
//  SplitSDK
//
//  Created by Bilal Al-Shahwany on 9/4/18.
//  Copyright © 2018 Split. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//MARK: Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func buttonAction(_ sender: UIButton) {
    }
    @IBAction func buttonDown(_ sender: UIButton) {
        print("button pressed")
        if (mySplit!.isSDKReady) {
            print("Treatment1: \(mySplit!.getSplitTreatment(splitName: "sample_feature"))")
//            let result = mySplit!.getSplitTreatmentWithConfig(splitName: "sample_feature")
//            print("\nTreatment1: \(result.treatment)")
//           let myData = result.data
//            let configKeys = try? JSONSerialization.jsonObject(with: myData, options: []) as? [String: String]
//            configKeys?!.forEach { key in
//                print("Key: \(key.key), Value: \(key.value)")
//            }
            let properties: [String:Any] = ["payment": "visa", "price": 50, "shipping": "ground"]
            if (!(mySplit?.sendTrack(trafficType: "client", eventType: "conversion", properties: properties))!) {
                print("Failed to send track event")
            }
        } else {
            print("SDK not ready yet")
        }
        if (mySplit2!.isSDKReady2) {
            print("Treatment2: \(mySplit2!.getSplitTreatment(splitName: "clients"))")
//            let result = mySplit2!.getSplitTreatmentWithConfig(splitName: "clients")
//            print("\nTreatment: \(result.treatment)")
//            let myData = result.data
//            let configKeys = try? JSONSerialization.jsonObject(with: myData, options: []) as? [String: String]
//            configKeys?!.forEach { key in
//                print("Key: \(key.key), Value: \(key.value)")
//            }
            let properties: [String:Any] = ["payment": "visa", "price": 50, "shipping": "ground"]
            if (!(mySplit2?.sendTrack(trafficType: "user", eventType: "conversion", properties: properties))!) {
                print("Failed to send track event")
            }
        } else {
            print("SDK2 not ready yet")
        }

    }
}

