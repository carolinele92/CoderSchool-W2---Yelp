//
//  SortByCell.swift
//  Yelp
//
//  Created by Caroline Le on 2/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit


class SortModeCell: UITableViewCell {

    @IBOutlet weak var sortModeLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        checkImage.isHidden = true
    }

}
