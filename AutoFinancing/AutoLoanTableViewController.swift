//
//  AutoLoanTableViewController.swift
//  Auto Loan
//
//  Created by Andi Setiyadi on 9/27/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class AutoLoanTableViewController: UITableViewController, UIPopoverControllerDelegate {
    
    var autoLoanTypes = [LoanType.Used60, LoanType.Used72, LoanType.New60, LoanType.New72, LoanType.Refi60, LoanType.Refi72]
    var myLoan: Loan?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove extra line separator
        tableView.tableFooterView = UIView()
        
        // Prevent popover dismissal when users tap anywhere
        self.modalInPopover = true
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
        return autoLoanTypes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellAutoLoanType", forIndexPath: indexPath)

        cell.textLabel?.text = (autoLoanTypes[indexPath.row]).rawValue

        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        myLoan!.setLoanType(autoLoanTypes[indexPath.row])
    }
}
