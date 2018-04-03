//: Playground - noun: a place where people can play

import UIKit

let TIP_KEY = "Tip_Key"
let SPLIT_KEY = "Split_Key"

let defaultTip = 15
let defaultSplit = 1

let defaults = UserDefaults.standard
if let tip = defaults.string(forKey: TIP_KEY),
    let split = defaults.string(forKey: SPLIT_KEY) {
    print(tip)
    print(split)
} else {
    print("Not there, adding them")
    defaults.set(defaultSplit, forKey: SPLIT_KEY)
    defaults.set(defaultTip, forKey: TIP_KEY)
}

