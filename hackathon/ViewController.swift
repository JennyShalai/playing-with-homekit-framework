//
//  ViewController.swift
//  hackathon
//
//  Created by Flatiron School on 9/3/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import HomeKit

class ViewController: UIViewController, HMAccessoryBrowserDelegate, HMAccessoryDelegate {

    let homeManager = HMHomeManager()
    let browser = HMAccessoryBrowser()
    var accessories = [HMAccessory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        browser.delegate = self
        browser.startSearchingForNewAccessories()
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func accessoryBrowser(browser: HMAccessoryBrowser, didFindNewAccessory accessory: HMAccessory) {
        accessories.append(accessory)
        print(accessories)
        
        if let room = homeManager.primaryHome?.rooms.first as HMRoom? {
            homeManager.primaryHome?.addAccessory(accessory, completionHandler: { (error) -> Void in
                if error != nil {
                    print("\(error?.localizedDescription)")
                } else {
                    self.homeManager.primaryHome?.assignAccessory(accessory, toRoom: room, completionHandler: {
                        (error) in
                        if error != nil {
                            print("\(error?.localizedDescription)")
                        } else {
                            "GEART we can do something"
                        }
                    })
                }
            })
        }
    }
    

}

