//
//  settingsViewController.swift
//  tip calculator
//
//  Created by Mac Lab on 1/30/18.
//  Copyright © 2018 Javar Finch. All rights reserved.
//

import UIKit

class settingsViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet weak var pickerView: UIPickerView!
    
    let tip = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35]
    let split = [1,2,3,4,5]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
            return split.count
        } else {
            return tip.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0) {
            return String(split[row])
        } else {
            return String(tip[row])
        }
    }
    
    
    
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func savePressed(_ sender: Any) {
        let finalSplit = split[pickerView.selectedRow(inComponent: 0)]
        let finalTip = tip[pickerView.selectedRow(inComponent: 1)]
        defaults.set(finalSplit, forKey: SPLIT_KEY)
        defaults.set(finalTip, forKey: TIP_KEY)
        dismiss(animated: true, completion: nil)
    }
}
