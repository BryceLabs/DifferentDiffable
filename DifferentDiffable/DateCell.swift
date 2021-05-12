//
//  DateCell.swift
//  DifferentDiffable
//
//  Created by Bryan Bryce on 5/12/21.
//

import UIKit

class DateCell: UITableViewCell {

    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(_ date: Date) {
        let formatter = DateFormatter()
        formatter.timeStyle = .long
        dateLabel.text = "\(formatter.string(from: date))"
    }
}
