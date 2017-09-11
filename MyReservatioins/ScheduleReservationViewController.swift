//
//  ScheduleReservationViewController.swift
//  MyReservatioins
//
//  Created by Swapnil Jain on 9/9/17.
//  Copyright © 2017 tbd. All rights reserved.
//

import UIKit
import CoreData

class ScheduleReservationViewController: UIViewController, UICollectionViewDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // IBOutlets
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var timeCollectionView: UICollectionView!
    @IBOutlet weak var reserveButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var rTitle: UILabel!
    @IBOutlet weak var rDescription: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    // Properties
    var picker = UIPickerView()
    let pickerData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    var isDaySelected = false
    var isTimeSelected = false
    
    var selectedDate = ""
    var selectedTime = ""
    
    // MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set back button title
        navigationController?.navigationItem.backBarButtonItem?.title = ""
        
        // Enable/disable reserve button
        enableDisableReserveButton()
        
        // Initiate picker view
        initiatePickerView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- IBAction
    func donePicker(_ sender: UIBarButtonItem){
        textField.text = pickerData[picker.selectedRow(inComponent: 0)]
        textField.resignFirstResponder()
    }
    
    func cancelPicker(_ sender: UIBarButtonItem){
        textField.resignFirstResponder()
    }
    
    @IBAction func scheduleReservation(_ sender: UIButton){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        // Save resevation in core data
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Reservations", in: managedContext)!
        let reservation = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // Set values
        reservation.setValue(rTitle.text, forKey: "title")
        reservation.setValue(rDescription.text, forKey: "description_")
        reservation.setValue(duration.text, forKey: "duration")
        reservation.setValue(Int16(textField.text!), forKey: "partySize")
        reservation.setValue(selectedDate, forKey: "date")
        reservation.setValue(selectedTime, forKey: "time")
        
        // Save
        do{
            try managedContext.save()
        }catch _ as NSError{
            // Handle error here
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK:- UICollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.backgroundColor = UIColor(red: 172.0/255, green: 204.0/255, blue: 234.0/255, alpha: 1.0)
        
        if collectionView == calendarCollectionView, let cell = cell as? DateCell{
            isDaySelected = true
            selectedDate = "\(cell.dayLabel.text!), \(cell.dateLabel.text!)"
        }else if collectionView == timeCollectionView, let cell = cell as? TimeCell{
            isTimeSelected = true
            selectedTime = cell.timeLabel.text!
        }
        
        enableDisableReserveButton()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.backgroundColor = UIColor.clear
    }
    
    // MARK:- UITextField Delegate methods
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        
//    }
    
    // MARK:- UIPickerView Data source, delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // MARK:- Enable/Disable Reserve button
    func enableDisableReserveButton(){
        if isDaySelected && isTimeSelected{
            // Enable Reserve
            reserveButton.isEnabled = true
            reserveButton.backgroundColor = UIColor(red: 17.0/255, green: 109.0/255, blue: 194.0/255, alpha: 1.0)
        }else{
            // Disable Reserve
            reserveButton.isEnabled = false
            reserveButton.backgroundColor = UIColor(red: 132.0/255, green: 178.0/255, blue: 220.0/255, alpha: 1.0)
        }
    }
    
    // MARK:- Picker view initialization
    func initiatePickerView(){
        picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 240))
        picker.backgroundColor = UIColor.white
        
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 246.0/255, green: 246.0/255, blue: 246.0/255, alpha: 1.0)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        doneButton.tintColor = UIColor(red: 17.0/255, green: 109.0/255, blue: 194.0/255, alpha: 1.0)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelPicker))
        cancelButton.tintColor = UIColor(red: 17.0/255, green: 109.0/255, blue: 194.0/255, alpha: 1.0)
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputView = picker
        textField.inputAccessoryView = toolBar
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
