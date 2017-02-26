//
//  BusinessCell.swift
//  Yelp
//
//  Created by Caroline Le on 2/23/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit
import AFNetworking

class BusinessCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    var business: Business! {
        didSet {
            nameLabel.text = business.name
            addressLabel.text = business.address
            categoryLabel.text = business.categories
            businessImage.setImageWith(business.imageURL!)
            ratingImage.setImageWith(business.ratingImageURL!)
            reviewCountLabel.text = String(describing: business.reviewCount!)
            distanceLabel.text = business.distance
        }
    }
        
    

}
