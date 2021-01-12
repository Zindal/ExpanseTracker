//
//  AddExpanseVC.swift
//  ExpanseTracker
//
//  Created by Zindal on 12/01/21.
//

import Foundation
import UIKit

class AddExpanseVC: UIViewController {

    @IBOutlet var txtTitle: UITextField!
    @IBOutlet var txtAmount: UITextField!
    @IBOutlet var txtCategpry: UITextField!
    @IBOutlet var txtDate: UITextField!
    @IBOutlet var txtNote: UITextField!
    let picker = UIPickerView()
    let datePicker = UIDatePicker()
    let categoryArr : [String]! = ["Fuel","Food","Hobby"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        txtDate.inputView = datePicker
        txtCategpry.inputView = picker
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(self.selectDate(datepicker:)), for: .valueChanged)
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.title = "Add Expanse"
    }
    
    @objc func selectDate(datepicker:UIDatePicker) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd-MM-yyyy"
        self.txtDate.text = dateformatter.string(from: datePicker.date)
    }
    
    func validateAll() -> Bool {
                
        if txtTitle.text == "" || txtAmount.text == "" || txtCategpry.text == "" || txtDate.text == "" {
            return false
        }
        
        return true
    }
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        
        if self.validateAll() {
            let dict : [String:String] = [
                "title" : txtTitle.text!,
                "category": txtCategpry.text!,
                "amount": txtAmount.text!,
                "date" : txtDate.text!,
                "note": txtNote.text ?? ""
            ]
            
            let status = CoreDataManager.shared.save(expnaseDict:dict)
            if status {
                let alert = UIAlertController(title: "Message", message: "Saved successfully", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .cancel)
                alert.addAction(okAction)
                present(alert, animated: true)
            }
            
        }
        else {
            print("Not valid")
            let alert = UIAlertController(title: "Error", message: "Please enter valid data", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
        
    }
    
}

extension AddExpanseVC: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.txtCategpry.text = categoryArr[row]
    }
    
}
