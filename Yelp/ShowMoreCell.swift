//
//  ShowMoreCell.swift
//  Yelp
//
//  Created by Caroline Le on 2/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol showMoreCellDelegate {
    func showMore (showMoreCell: ShowMoreCell, showMoreButtonDidTap action: Bool)
}

class ShowMoreCell: UITableViewCell {
    
    @IBOutlet weak var showAllLabel: UILabel!
    var delegate: showMoreCellDelegate?
    
    
}
