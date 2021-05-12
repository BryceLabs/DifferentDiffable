//
//  NumberCell.swift
//  DifferentDiffable
//
//  Created by Bryan Bryce on 5/12/21.
//

import UIKit

class NumberCell: UITableViewCell {

    @IBOutlet var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ number: Int) {
        numberLabel.text = "\(number)"
    }
}
