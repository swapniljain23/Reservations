//
//  MyReservationCollectionViewCell.swift
//  MyReservatioins
//
//  Created by Swapnil Jain on 9/10/17.
//  Copyright © 2017 tbd. All rights reserved.
//

import UIKit

class MyReservationCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var rTitle: UILabel!
    @IBOutlet weak var rDescription: UILabel!
    @IBOutlet weak var partySize: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var rDate: UILabel!
    @IBOutlet weak var rTime: UILabel!
    
    @IBOutlet weak var rescheduleButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
}
