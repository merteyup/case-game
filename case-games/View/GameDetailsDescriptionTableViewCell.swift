//
//  GameDetailsDescriptionTableViewCell.swift
//  case-games
//
//  Created by Eyüp Mert on 5.06.2023.
//

import UIKit

class GameDetailsDescriptionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblGameDescriptionHeader: UILabel!
    @IBOutlet weak var lblGameDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
