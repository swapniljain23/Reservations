//
//  ViewController.swift
//  MyReservatioins
//
//  Created by Swapnil Jain on 9/9/17.
//  Copyright © 2017 tbd. All rights reserved.
//

import UIKit
import CoreData

class MyReservationsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    // IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // All reservations
    var reservations: [NSManagedObject] = []
    
    // MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set back button title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // Fetch reservations
        fetchMyScheduleReservations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Fetch reservations
        fetchMyScheduleReservations()
    }
    
    // MARK:- UICollectionView Datasource, delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reservations.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize(width: 0, height: 15.0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize{
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyReservation", for: indexPath)
        
        if let cell = cell as? MyReservationCollectionViewCell{
            let reservation = reservations[indexPath.row]
            
            cell.cancelButton.layer.cornerRadius = 5.0
            cell.rescheduleButton.layer.cornerRadius = 5.0
            
            cell.rTitle.text = reservation.value(forKey: "title") as? String
            cell.rDescription.text = reservation.value(forKey: "description_") as? String
            cell.duration.text = reservation.value(forKey: "duration") as? String
            cell.partySize.text = String(describing: (reservation.value(forKey: "partySize") as? Int)!)
            cell.rDate.text = reservation.value(forKey: "date") as? String
            cell.rTime.text = reservation.value(forKey: "time") as? String
        }
        return cell
    }
    
    // MARK:- Fetch/reload data
    func fetchMyScheduleReservations(){
        // Fetch
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Reservations")
        
        do{
            reservations = try managedContext.fetch(fetchRequest)
        }catch _ as NSError{
            // Handle error
        }
        
        // Reload
        collectionView.reloadData()
    }
}

