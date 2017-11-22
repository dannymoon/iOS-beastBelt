//
//  beastedCell.swift
//  BeastBelt
//
//  Created by Danny Moon on 11/19/17.
//  Copyright © 2017 Danny Moon. All rights reserved.
//

import UIKit

class beastCell: UITableViewCell {
    weak var delegate: beastCellDelegate?
    @IBOutlet weak var beastButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func beastButtonPressed(_ sender: UIButton) {
        self.delegate?.selected(sender: self)
    }
}

