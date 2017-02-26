//
//  SwitchCell.swift
//  Yelp
//
//  Created by Caroline Le on 2/24/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol SwitchCellDelegate {
    func switchCell (switchCell: SwitchCell, didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    var delegate: SwitchCellDelegate?

    
    
    
    @IBAction func onSwitch(_ sender: UISwitch) {
        
        print ("switch changed to \(sender.isOn)")
        delegate?.switchCell(switchCell: self, didChangeValue: sender.isOn)
    }
}
