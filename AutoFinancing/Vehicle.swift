//
//  Vehicle.swift
//  Auto Loan
//
//  Created by Andi Setiyadi on 9/29/15.
//  Copyright © 2015 Andi Setiyadi. All rights reserved.
//

import Foundation
import UIKit

class Vehicle {
    
    var autoMakers = [String]()
    
    func createAutoMakerList() {
        /* Using NSURLSession */
        let url = NSURL(string: "http://autotrader.mybluemix.net/api/v1/car/make")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) -> Void in
            if let urlContent = data {
                do {
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                    NSString(data: data!, encoding: NSUTF8StringEncoding)
                    
                    if jsonResult.count > 0 {
                        //var tempAutos = [String]()
                        if let items = jsonResult as? [String] {
                            for item in items {
                                self.autoMakers.append(item as String)
                            }
                            
                            // To update the UI from background thread, need to get the main thread
                            //dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                //self.autoMakerTableView.reloadData()
                            //})
                        }
                    }
                }
                catch {
                    
                }
            }
        }
        
        task.resume()
        
    }
    

}
