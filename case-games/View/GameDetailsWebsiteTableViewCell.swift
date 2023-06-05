//
//  GameDetailWebsiteTableViewCell.swift
//  case-games
//
//  Created by Eyüp Mert on 5.06.2023.
//

import UIKit

protocol GameDetailsWebsiteTableViewCellDelegate : AnyObject {
    func websiteAction()
}

class GameDetailsWebsiteTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    weak var gameDetailsWebsiteTableViewCellDelegate : GameDetailsWebsiteTableViewCellDelegate?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - IBActions
    @IBAction func visitWebsitePressed(_ sender: Any) {
        gameDetailsWebsiteTableViewCellDelegate?.websiteAction()
    }
    

}
