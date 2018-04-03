//
//  ViewController.swift
//  tip calculator
//
//  Created by Mac Lab on 1/29/18.
//  Copyright © 2018 Javar Finch. All rights reserved.
//

import UIKit

let TIP_KEY = "Tip_Key"
let SPLIT_KEY = "Split_Key"

class ViewController: UIViewController {

    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var checkAmountTextField: UITextField!
    @IBOutlet weak var TotalTipTextField: UITextField!
    @IBOutlet weak var totalAmountTextField: UITextField!
    @IBOutlet weak var tipEachTextField: UITextField!
    @IBOutlet weak var totalEachTextField: UITextField!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var splitControl: UISegmentedControl!
    
    let defaults = UserDefaults.standard
    var checkAmount = 0.0
    var totalTip = 0.0
    var currentSplit = 0
    let defaultSplit = 1
    var splitTip = 0.0
    var currentTipPercentage =  0
    var totalEach = 0.0
    let fmt = NumberFormatter()
    let defaultTip = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fmt.numberStyle = .currency
        fmt.locale = Locale(identifier: "en_US")
        totalEachTextField.isUserInteractionEnabled = false
        TotalTipTextField.isUserInteractionEnabled = false
       totalAmountTextField.isUserInteractionEnabled = false
        tipEachTextField.isUserInteractionEnabled = false
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDefaults()
    }
    
    func getDefaults() {
        if let tip = defaults.string(forKey: TIP_KEY),
            let split = defaults.string(forKey: SPLIT_KEY) {
            let realTip = convertToDouble(wantedDouble: tip)
            tipSlider.value = Float(realTip)
            percentLabel.text = String(Int(realTip)) + "%"
            let realSplit = convertToDouble(wantedDouble: split)
            splitControl.selectedSegmentIndex = Int(realSplit) - 1
        } else {
            print("Not there, adding them")
            tipSlider.value = Float(defaultTip)
            splitControl.selectedSegmentIndex = defaultSplit - 1
            defaults.set(defaultSplit, forKey: SPLIT_KEY)
            defaults.set(defaultTip, forKey: TIP_KEY)
        }

    }
    
    func convertToDouble(wantedDouble: String)->Double {
        var double = 0.0
        if let temp = Double(wantedDouble) {
            double = temp
        } else {
            double = 0.0
        }
        return double
    }
    func calculateTotalTip(check: Double) {
        currentTipPercentage = Int(tipSlider.value)
        totalTip = check * (Double(currentTipPercentage) * 0.01)
    }
    func  calculateTipSplit(tip: Double) {
        currentSplit = splitControl.selectedSegmentIndex + 1
        splitTip = tip / Double(currentSplit)
    }
    
    func calculateTotalEach() {
        totalEach = (checkAmount / Double(currentSplit)) + splitTip
    }
    func getCheckAmount() {
        var checkString = ""
        if let temp = checkAmountTextField.text {
            checkString = temp
        } else {
            checkString = ""
        }
        if let temp = Double(checkString) {
            checkAmount = temp
        } else {
            checkAmount = 0.0
        }

    }
    @IBAction func sliderMoved(_ sender: UISlider) {
        currentTipPercentage = Int(sender.value)
        percentLabel.text = String(currentTipPercentage) + "%"
        calculateButtonPressed(calculateButton)
    }
    
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        checkAmountTextField.resignFirstResponder()
        // get text from textfield and convert to double
        getCheckAmount()
        // calculate total tip from tip percentage and display it in total tip
        calculateTotalTip(check: checkAmount)
        TotalTipTextField.text = fmt.string(for: totalTip)
        // add the total tip to the checkAmount and display it in total amount
        totalAmountTextField.text = fmt.string(for: checkAmount + totalTip)
        // get the tip split for each person and display it in tip each
        calculateTipSplit(tip: totalTip)
        tipEachTextField.text = fmt.string(for: splitTip)
        //calculate the total for each person and display it in total each
        calculateTotalEach()
        totalEachTextField.text = fmt.string(for: totalEach)
    }
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        getDefaults()
        checkAmountTextField.text = "0.00"
        calculateButtonPressed(calculateButton)
    }
    @IBAction func splitChanged(_ sender: UISegmentedControl) {
        currentSplit = sender.selectedSegmentIndex + 1
        calculateButtonPressed(calculateButton)
    }
}



