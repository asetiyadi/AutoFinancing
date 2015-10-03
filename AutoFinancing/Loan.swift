//
//  Loan.swift
//  Auto Loan
//
//  Created by Andi Setiyadi on 9/24/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import Foundation


class Loan  {
    var loanType: String = ""
    var vehicleMake: String = ""
    var vehicleModel: String = ""
    var maxDownPayment: Int = 2500
    var maxMonthlyPayment: Int = 250
    var maxPurchasePrice: Int = 30000
    var interestRate: Double = 1.99
    var tradeInValue: Int = 0

  
//    init(maxMonthlyPayment: Int) {
//        self.maxMonthlyPayment = maxMonthlyPayment
//    }

    func getLoanType() -> String {
        return loanType
    }
    func setLoanType(loanType: String) {
        self.loanType = loanType
    }
    
    func getVehicleMake() -> String {
        return vehicleMake
    }
    func setVehicleMake(vehicleMake: String) {
        self.vehicleMake = vehicleMake
    }
    
    func getVehicleModel() -> String {
        return vehicleModel
    }
    func setVehicleModel(vehicleModel: String) {
        self.vehicleModel = vehicleModel
    }
    
    func getMaxDownPayment() -> Int {
        return maxDownPayment
    }
    func setMaxDownPayment(maxDownPayment: Int) {
        self.maxDownPayment = maxDownPayment
    }
    
    func getMaxMonthlyPayment() -> Int {
        return maxMonthlyPayment
    }
    func setMaxMonthlyPayment(maxMonthlyPayment: Int) {
        self.maxMonthlyPayment = maxMonthlyPayment
    }
    
    func getMaxPurchasePrice() -> Int {
        return maxPurchasePrice
    }
    func setMaxPurchasePrice(maxPurchasePrice: Int) {
        self.maxPurchasePrice = maxPurchasePrice
    }
    
    func getInterestRate() -> Double {
        return interestRate
    }
    func setInterestRate(interestRate: Double) {
        self.interestRate = interestRate
    }
    
    func getTradeInValue() -> Int {
        return tradeInValue
    }
    func setTradeInValue(tradeInValue: Int) {
        self.tradeInValue = tradeInValue
    }
    
    func calculateMonthlyPayment() -> (principal: Double, interest: Double) {
        let vehiclePrice = Double(self.maxPurchasePrice)
        let downPayment = Double(self.maxDownPayment)
        let interestRate: Double = self.interestRate/100
        let amountBeingFinanced = vehiclePrice - downPayment - Double(tradeInValue)
        
        let interestRatePerMonth = interestRate / 12
        let numberOfPeriod = 60.0
        let paymentFactor = (1 - pow((1 + interestRatePerMonth), -1.0 * numberOfPeriod)) / interestRatePerMonth
        let monthlyPayment = round(100 * (amountBeingFinanced / paymentFactor))/100
        let monthlyInterest = round(100 * interestRatePerMonth * amountBeingFinanced)/100
        let monthlyPrincipal = monthlyPayment - monthlyInterest
        
        return (monthlyPrincipal, monthlyInterest)
    }
}
