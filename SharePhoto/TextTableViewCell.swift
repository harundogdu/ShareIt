//
//  TextTableViewCell.swift
//  SharePhoto
//
//  Created by Harun on 19.06.2021.
//

import UIKit

class TextTableViewCell: UITableViewCell{
    @IBOutlet weak var userTextLabel: UILabel!
    
    @IBOutlet weak var userUserNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
