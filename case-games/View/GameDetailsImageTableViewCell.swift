//
//  GameDetailsImageTableViewCell.swift
//  case-games
//
//  Created by Eyüp Mert on 5.06.2023.
//

import UIKit

class GameDetailsImageTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var imgGame: UIImageView!
    @IBOutlet weak var lblGameName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
