//
//  LoanParameterTableViewController.swift
//  Auto Loan
//
//  Created by Andi Setiyadi on 9/22/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

protocol LoanParameterSelectionDelegate: class {
    func loanParameterSelected(newLoan: Loan)
    //func maxPayment(newPayment: Int)
}



class LoanParameterTableViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: delegate
    
    // delegate object is initialized in AppDelegate
    weak var delegate: LoanParameterSelectionDelegate?
    
    
    // MARK: Properties
    
    var myLoan = Loan()
    var vehicle = Vehicle()
    var autoMakers = [String]()
    var loanInfoViewController: LoanInfoViewController? = nil
    
    @IBOutlet weak var autoLoanTypeButton: UIButton!
    @IBOutlet weak var autoMakerButton: UIButton!
    @IBOutlet weak var autoModelButton: UIButton!
    
    
    @IBOutlet weak var homeLocationField: UITextField!
    @IBOutlet weak var militarySwitch: UISwitch!
    
    // Max down payment
    @IBOutlet weak var maxDownPaymentDollarField: UITextField!
    @IBOutlet weak var maxDownPaymentSlider: UISlider!
    
    // Max monthly payment
    @IBOutlet weak var maxMonthlyPaymentField: UITextField!
    @IBOutlet weak var maxMonthlyPaymentSlider: UISlider!
    
    // Max purchase price
    @IBOutlet weak var maxPurchasePriceField: UITextField!
    @IBOutlet weak var maxPurchasePriceSlider: UISlider!
    
    @IBOutlet weak var tradeInValueField: UITextField!
    @IBOutlet weak var interestRateField: UITextField!
    
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Max down payment
        maxDownPaymentDollarField.text = String(Int(maxDownPaymentSlider.value))
        maxDownPaymentDollarField.addTarget(self, action: "loanUpdate:", forControlEvents: UIControlEvents.EditingChanged)
        maxDownPaymentSlider.addTarget(self, action: "setSliderValue:", forControlEvents: UIControlEvents.ValueChanged)
        maxDownPaymentSlider.addTarget(self, action: "loanUpdate:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Max monthly payment
        maxMonthlyPaymentField.text = String(Int(maxMonthlyPaymentSlider.value))
        maxMonthlyPaymentField.addTarget(self, action:"loanUpdate:", forControlEvents: UIControlEvents.EditingChanged)
        maxMonthlyPaymentSlider.addTarget(self, action: "setSliderValue:", forControlEvents: UIControlEvents.ValueChanged)
        maxMonthlyPaymentSlider.addTarget(self, action: "loanUpdate:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Max purchase price
        maxPurchasePriceField.text = String(Int(maxPurchasePriceSlider.value))
        maxPurchasePriceField.addTarget(self, action:"loanUpdate:", forControlEvents: UIControlEvents.EditingChanged)
        maxPurchasePriceSlider.addTarget(self, action: "setSliderValue:", forControlEvents: UIControlEvents.ValueChanged)
        maxPurchasePriceSlider.addTarget(self, action: "loanUpdate:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Trade in Value
        tradeInValueField.addTarget(self, action: "loanUpdate:", forControlEvents: UIControlEvents.EditingChanged)
        
        // Interest rate
        interestRateField.addTarget(self, action: "loanUpdate:", forControlEvents: UIControlEvents.EditingChanged)

        // Restrict users to select auto model before the auto maker is selected
        autoModelButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Actions
    
    @IBAction func sliderValueChange(sender: UISlider) {
        maxDownPaymentDollarField.text = String(sender.value)
        maxDownPaymentSlider.value = Float(maxDownPaymentDollarField.text!)!
    }
    
    @IBAction func maxMonthlyPaymentSlider(sender: UISlider) {
        maxMonthlyPaymentField.text = String(sender.value)
        maxMonthlyPaymentSlider.value = Float(maxMonthlyPaymentField.text!)!
    }
    
    @IBAction func maxPurchasePriceSlider(sender: UISlider) {
        maxPurchasePriceField.text = String(sender.value)
        maxPurchasePriceSlider.value = Float(maxPurchasePriceField.text!)!
    }
    
    func setSliderValue(sender: UISlider) {
        var sliderValue: Int!
        print("sender = \(sender.tag)")
        
        switch Int(sender.tag) {
            case 0:     // Downpayment
                print(sender.value)
                sliderValue = Int((sender.value + 2.5) / 100) * 100
                maxDownPaymentDollarField.text = String(sliderValue)
            
            case 1:     // Max payment
                sliderValue = Int((sender.value + 2.5) / 5) * 5
                maxMonthlyPaymentField.text = String(sliderValue)
            
            case 3:     // Max payment
                sliderValue = Int((sender.value + 2.5) / 1000) * 1000
                maxPurchasePriceField.text = String(sliderValue)
            
            default:
                break
        }
        
        sender.setValue(Float(sliderValue), animated: true)
    }
    
    func loanUpdate(sender: AnyObject) {

        if tradeInValueField.text != "" {
            myLoan.setTradeInValue(Int(tradeInValueField.text!)!)
        }
        
        // Update Loan information
        myLoan.setMaxDownPayment(Int((maxDownPaymentDollarField.text! as NSString).floatValue))
        myLoan.setMaxMonthlyPayment(Int((maxMonthlyPaymentField.text! as NSString).floatValue))
        myLoan.setMaxPurchasePrice(Int((maxPurchasePriceField.text! as NSString).floatValue))
        myLoan.setInterestRate(Double(interestRateField.text!)!)

        // Inform loanInfoViewController about the update on loan parameter
        delegate?.loanParameterSelected(myLoan)

        if let loanInfoViewController = delegate as? LoanInfoViewController {
            splitViewController?.showDetailViewController(loanInfoViewController, sender: nil)
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 14
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //cell.backgroundColor = UIColor.yellowColor()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier! == "segueAutoLoanType" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let autoLoanTypeController = navigationController.topViewController as! AutoLoanTableViewController
            
            autoLoanTypeController.myLoan = myLoan
        }
        else if segue.identifier! == "segueAutoMakers" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let vehicleMakeController = navigationController.topViewController as! VehicleMakeTableViewController
            
            vehicleMakeController.myLoan = myLoan
        }
        else if segue.identifier == "segueAutoModels" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let vehicleModelController = navigationController.topViewController as! VehicleModelTableViewController
            
            vehicleModelController.myLoan = myLoan
        }
    }
    
    @IBAction func unwindToMasterView(segue: UIStoryboardSegue) {
        autoLoanTypeButton.setTitle(myLoan.getLoanType().rawValue, forState: UIControlState.Normal)
        
        if myLoan.getVehicleMake() != "" {
            autoMakerButton.setTitle(myLoan.getVehicleMake(), forState: UIControlState.Normal)
            autoModelButton.setTitle("Select Vehicle Model", forState: UIControlState.Normal)
            autoModelButton.enabled = true
        }
        
        if myLoan.getVehicleModel() != "" {
            autoModelButton.setTitle(myLoan.getVehicleModel(), forState: UIControlState.Normal)
        }
        
        loanUpdate(self)
    }
}
