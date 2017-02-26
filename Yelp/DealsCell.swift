//
//  DealsCell.swift
//  Yelp
//
//  Created by Caroline Le on 2/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol DealsCellDelegate {
    func dealsCell (didChangeValue value: Bool)
}

class DealsCell: UITableViewCell {

    @IBOutlet weak var dealsLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    var delegate: DealsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func onSwitch(_ sender: UISwitch) {
        delegate?.dealsCell(didChangeValue: sender.isOn)
    }

}
