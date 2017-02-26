//
//  DistanceCell.swift
//  Yelp
//
//  Created by Caroline Le on 2/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol DistanceCellDelegate {
    func distanceCell (distanceCell: DistanceCell, didSelectDistanceValue value: Int)
}

class DistanceCell: UITableViewCell {

    @IBOutlet weak var distanceControl: UISegmentedControl!
    

    var delegate: DistanceCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func distanceControlAction(_ sender: UISegmentedControl) {
        
        delegate?.distanceCell(distanceCell: self, didSelectDistanceValue: sender.selectedSegmentIndex)
    }

}
