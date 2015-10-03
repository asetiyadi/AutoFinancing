//
//  LoanInfoViewController.swift
//  Auto Loan
//
//  Created by Andi Setiyadi on 9/24/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Charts

class LoanInfoViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var vehicleYearLabel: UILabel!
    @IBOutlet weak var vehicleMakeLabel: UILabel!
    @IBOutlet weak var vehicleModelLabel: UILabel!
    @IBOutlet weak var loanTypeLabel: UILabel!
    
    
    //@IBOutlet weak var pieChartView: PieChartView!
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var loanDetailView: UIView!
    @IBOutlet weak var monthlyPaymentLabel: UILabel!
    @IBOutlet weak var sampleCarImageView: UIImageView!
    
    
    var loan: Loan! {
        didSet(newLoan) {
            self.refreshUI()
        }
    }
    
    var maxPayment: Int = 100 {
        didSet(newPayment) {
            self.refreshUI()
        }
    }
    
    @IBOutlet weak var maxMonthlyPaymentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loanDetailView.layer.borderWidth = 2
        loanDetailView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).CGColor
        loanDetailView.layer.cornerRadius = 10
        
        sampleCarImageView.layer.borderWidth = 2
        sampleCarImageView.layer.borderColor = UIColor.grayColor().CGColor
        sampleCarImageView.layer.cornerRadius = 5
        
        
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshUI() {
        print(String(maxPayment))
        if let loan = loan {
            //maxMonthlyPaymentLabel.text = String(loan.getMaxMonthlyPayment())
            
//            vehicleYearLabel.text
            //vehicleMakeLabel.text = loan.getVehicleMake()
            //loanTypeLabel.text = loan.getLoanType()
        }
        
        if let loan = loan {
            let monthlyPayments = loan.calculateMonthlyPayment()
            let paymentTypes = ["Principal", "Interest"]
            let paymentAmount = [monthlyPayments.principal, monthlyPayments.interest]
            let monthlyPayment = monthlyPayments.principal + monthlyPayments.interest
            
            monthlyPaymentLabel.text = "$ \(monthlyPayment)"
            
            setChart(paymentTypes, values: paymentAmount)
        }
        
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for x in 0..<dataPoints.count {
            var dataEntry = ChartDataEntry(value: values[x], xIndex: x)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        pieChartView.descriptionText = ""
        pieChartView.animate(xAxisDuration: 0.75, yAxisDuration: 0.75)
        //pieChartView.holeRadiusPercent = 80
        pieChartView.legend.enabled = false
        
        
        
        var colors: [UIColor] = []
        var color: UIColor!
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            if i == 0 {
                color = UIColor(red: 0.047, green: 0.325, blue: 0.533, alpha: 1)
            }
            else {
                color = UIColor(red: 0.867, green: 0.294, blue: 0.224, alpha: 1)
            }
            
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors

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

extension LoanInfoViewController: LoanParameterSelectionDelegate {
    func loanParameterSelected(newLoan: Loan) {
        loan = newLoan
    }
    
    func maxPayment(newPayment: Int) {
        maxPayment = newPayment
    }
}