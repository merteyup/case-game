//
//  MainGamesTableViewCell.swift
//  case-games
//
//  Created by Eyüp Mert on 31.05.2023.
//

import UIKit

class MainGamesTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var lblGameName: UILabel!
    @IBOutlet weak var imgGame: UIImageView!
    @IBOutlet weak var lblMetaCritic: UILabel!
    @IBOutlet weak var lblMetaCriticScore: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    
    // MARK: - Statements
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    // MARK: - Functions
    
    override func prepareForReuse() {
        super.prepareForReuse()
        /// Clear table view cell for reusable purpose.
        lblGameName.text = nil
        lblGenres.text = nil
        lblMetaCriticScore.text = nil
        imgGame.image = nil
    }
    
    /// Update cell with current game's information
    /// - Parameter currentGame: Game which is in the cell currently.
    func updateCell(currentGame: Game) {
        
        /// Fill labels with current game informations.
        lblGameName.text = currentGame.name
        lblMetaCriticScore.text = String(currentGame.metacritic)
        lblMetaCritic.text = "metacritic: "
        
        /// Check is current game has single or multiple genre and act accordingly.
        if currentGame.genres.count == 1 {
            lblGenres.text = currentGame.genres.first?.name
        } else {
            let genresArray = currentGame.genres.map({ (genre: Genre) -> String in
                genre.name
            })
            let stringGenres = genresArray.joined(separator: ", ")
            lblGenres.text = stringGenres
        }
        
        /// Check is game has valid url for image.
        guard let url = URL(string: currentGame.background_image) else { return }
        /// Load image with extension and use it in image view. Could be done with Alamofire or SDWebImage pods.
        UIImage.loadFrom(url: url) { image in
            self.imgGame.image = image
        }
    }
    
}

