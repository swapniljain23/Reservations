//
//  TimeDataSource.swift
//  MyReservatioins
//
//  Created by Swapnil Jain on 9/9/17.
//  Copyright © 2017 tbd. All rights reserved.
//

import UIKit

class TimeDataSource: NSObject, UICollectionViewDataSource {
    
    let availableTimes = ["09:00 AM", "10:00 AM", "11:00 AM", "12:00 PM", "01:00 PM", "02:00 PM", "03:00 PM", "04:00 PM", "05:00 PM", "06:00 PM", "07:00 PM", "08:00 PM"]
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return availableTimes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCell", for: indexPath)
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor(red: 222.0/255, green: 222.0/255, blue: 222.0/255, alpha: 1.0).cgColor
        
        if let cell = cell as? TimeCell{
            cell.timeLabel.text = availableTimes[indexPath.row]
        }
        
        if cell.isSelected{
            cell.contentView.backgroundColor = UIColor(red: 172.0/255, green: 204.0/255, blue: 234.0/255, alpha: 1.0)
        }else{
            cell.contentView.backgroundColor = UIColor.clear
        }
        
        return cell
    }
}
