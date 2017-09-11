//
//  CalendarDataSource.swift
//  MyReservatioins
//
//  Created by Swapnil Jain on 9/9/17.
//  Copyright © 2017 tbd. All rights reserved.
//

import UIKit

class CalendarDataSource: NSObject, UICollectionViewDataSource {
    let days = ["MON","TUE","WED","THU","FRI","SAT","SUN"]
    let date = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"]
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return date.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath)
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor(red: 222.0/255, green: 222.0/255, blue: 222.0/255, alpha: 1.0).cgColor
        
        if let cell = cell as? DateCell{
            var index = indexPath.row
            if index >= days.count{
                index = index % days.count
            }
            cell.dayLabel.text = days[index]
            cell.dateLabel.text = date[indexPath.row]
        }
        
        if cell.isSelected{
            cell.contentView.backgroundColor = UIColor(red: 172.0/255, green: 204.0/255, blue: 234.0/255, alpha: 1.0)
        }else{
            cell.contentView.backgroundColor = UIColor.clear
        }
        return cell
    }
}
