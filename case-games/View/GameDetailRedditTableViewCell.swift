//
//  GameDetailsRedditTableViewCell.swift
//  case-games
//
//  Created by Eyüp Mert on 5.06.2023.
//

import UIKit

protocol GameDetailsRedditTableViewCellDelegate : AnyObject {
    
    func redditAction()
    
}

class GameDetailsRedditTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    
    weak var gameDetailsRedditTableViewCellDelegate : GameDetailsRedditTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - IBActions

    @IBAction func visitRedditPressed(_ sender: Any) {
        gameDetailsRedditTableViewCellDelegate?.redditAction()
    }
    
    
}
