//
//  MyTableViewCell.swift
//  1200 StudentManager 03
//
//  Created by Trương Quang on 7/8/19.
//  Copyright © 2019 Trương Quang. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var outletImage: UIImageView!
    @IBOutlet weak var outletName: UILabel!
    @IBOutlet weak var outletPhoneNumber: UILabel!
    
    var inforStudent: InforStudent? {
        didSet {
            outletImage.layer.cornerRadius = outletImage.frame.width / 2
            outletImage.layer.borderWidth = 1
            outletImage.layer.borderColor = UIColor.gray.cgColor
            outletImage.layer.masksToBounds = true
            
            outletImage.image = inforStudent?.image
            outletName.text = inforStudent?.name
            outletPhoneNumber.text = inforStudent?.phoneNumber
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
