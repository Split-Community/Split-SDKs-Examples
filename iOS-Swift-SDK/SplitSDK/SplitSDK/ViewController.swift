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
            print("Treatment: \(mySplit!.getSplitTreatment(splitName: "clients"))")
            let result = mySplit!.getSplitTreatmentWithConfig(splitName: "clients")
            print("\nTreatment: \(result.treatment)")
            let myData = result.data
            let configKeys = try? JSONSerialization.jsonObject(with: myData, options: []) as? [String: String]
            configKeys?!.forEach { key in
                print("Key: \(key.key), Value: \(key.value)")
            }
        } else {
            print("SDK not ready yet")
        }

    }
}

