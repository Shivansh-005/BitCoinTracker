//
//  ViewController.swift
//  BitcoinTracker
//
//  Created by Shivansh on 10/12/20.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate, finishedFetching {
    
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var priceManagerObj=PriceManager()
    
    @IBOutlet weak var countryPicker: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priceManagerObj.currencyArray.count
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priceManagerObj.currencyArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(row>0){
        currencyLabel.text=priceManagerObj.currencyArray[row]
            self.priceManagerObj.getPrice(row)
        
        }
        
    }
    
    func finished(_ data: ReturnInfo) {
        DispatchQueue.main.async {
            self.priceLabel.text=String(format: "%0.5f", data.rate)
        self.timeLabel.text="Last Updated: "+data.time+" (UTC)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPicker.dataSource=self
        countryPicker.delegate=self
        priceManagerObj.delegate=self
        // Do any additional setup after loading the view.
    }


}

