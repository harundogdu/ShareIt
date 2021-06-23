//
//  FeedCell.swift
//  SharePhoto
//
//  Created by Harun on 18.06.2021.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
