//
//  VehicleMakeTableViewController.swift
//  Auto Loan
//
//  Created by Andi Setiyadi on 9/29/15.
//  Copyright © 2015 Andi Setiyadi. All rights reserved.
//

import UIKit

class VehicleMakeTableViewController: UITableViewController {

    var autoMakers = [String]()
    var myLoan: Loan?
    
    @IBOutlet var autoMakerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createAutoMakerList()
        
        // Remove extra line separator
        tableView.tableFooterView = UIView()
        
        // Prevent popover dismissal when users tap anywhere
        self.modalInPopover = true
    }
    
    func createAutoMakerList() {
        /* Using NSURLSession */
        let url = NSURL(string: "http://autotrader.mybluemix.net/api/v1/car/make")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) -> Void in
            if error != nil {
                self.autoMakers.append("Error: Unable to retrieve vehicle info")
            }
            
            if let _ = data {
                do {
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                    //NSString(data: data!, encoding: NSUTF8StringEncoding)
                    
                    if jsonResult.count > 0 {
                        //var tempAutos = [String]()
                        if let items = jsonResult as? [String] {
                            for item in items {
                                self.autoMakers.append(item as String)
                            }
                        }
                    }
                    else {
                        self.autoMakers.append("Unable to retrieve vehicle info")
                    }
                }
                catch {
                    print("Error caught")
                }
            }
            
            // To update the UI from background thread, need to get the main thread
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.autoMakerTableView.reloadData()
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
        return autoMakers.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellAutoMaker", forIndexPath: indexPath)

        cell.textLabel?.text = autoMakers[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        myLoan!.setVehicleMake(autoMakers[indexPath.row])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
