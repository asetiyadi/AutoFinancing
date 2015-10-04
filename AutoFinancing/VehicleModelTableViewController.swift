//
//  VehicleModelTableViewController.swift
//  AutoFinancing
//
//  Created by Andi Setiyadi on 10/2/15.
//  Copyright © 2015 Andi Setiyadi. All rights reserved.
//

import UIKit

class VehicleModelTableViewController: UITableViewController {

    var autoModels = [String]()
    var myLoan: Loan?
    
    @IBOutlet var autoModelTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createAutoModelList()
        
        // Remove extra line separator
        tableView.tableFooterView = UIView()
        
        // Prevent popover dismissal when users tap anywhere
        self.modalInPopover = true
    }
    
    func createAutoModelList() {
        /* Using NSURLSession */
        let stringURL = "http://autotrader.mybluemix.net/api/v1/car/" + (myLoan?.getVehicleMake())! + "/model"
        let url = NSURL(string: stringURL)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) -> Void in
            if error != nil {
                self.autoModels.append("Error: Unable to retrieve vehicle info")
            }
            
            if let _ = data {
                do {
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                    //NSString(data: data!, encoding: NSUTF8StringEncoding)
                    
                    if jsonResult.count > 0 {
                        //var tempAutos = [String]()
                        if let items = jsonResult as? [String] {
                            for item in items {
                                self.autoModels.append(item as String)
                            }
                        }
                    }
                }
                catch {
                    
                }
            }
            
            // To update the UI from background thread, need to get the main thread
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.autoModelTableView.reloadData()
            })
        }
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return autoModels.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellAutoModel", forIndexPath: indexPath)

        cell.textLabel?.text = autoModels[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        myLoan!.setVehicleModel(autoModels[indexPath.row])
    }

}
