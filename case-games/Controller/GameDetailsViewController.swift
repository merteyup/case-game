//
//  GameDetailsViewController.swift
//  case-games
//
//  Created by Eyüp Mert on 31.05.2023.
//

import UIKit

class GameDetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var currentGameId : Int?
    private var currentGameDetail : GameDetail?

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            /// Check is current game id filled value from previous view controller.
            if let currentGameId = self.currentGameId {
                /// Get current game details depending on game id.
                self.getSingleGameDetail(gameId: currentGameId)
            }
        }
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Functions
    
    fileprivate func getSingleGameDetail(gameId: Int) {
             
        guard let request = Request(gameId: String(gameId)) else {
            return
        }
        Service.shared.execute(request,
                               expecting: GameDetail.self) { result in
            switch result {
            case .success(let success):
                self.currentGameDetail = success
            case .failure(let failure):
                print(failure)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}


extension GameDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GameDetailsImageTableViewCellID") as! GameDetailsImageTableViewCell
            if let currentGameDetail = currentGameDetail {
                cell.lblGameName.text = currentGameDetail.name
                if let url = currentGameDetail.background_image {
                    UIImage.loadFrom(url: URL(string: url)!) { image in
                        cell.imgGame.image = image
                    }
                }
            }
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GameDetailsDescriptionTableViewCellID") as! GameDetailsDescriptionTableViewCell
            cell.lblGameDescriptionHeader.text = "Game Description"
            if let currentGameDetail = currentGameDetail {
                cell.lblGameDescription.text = currentGameDetail.description
            }
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GameDetailsRedditTableViewCellID") as! GameDetailsRedditTableViewCell
            cell.gameDetailsRedditTableViewCellDelegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GameDetailsWebsiteTableViewCellID") as! GameDetailsWebsiteTableViewCell
            cell.gameDetailsWebsiteTableViewCellDelegate = self
            return cell
        }
        
    }
    
}

/// Normally I could find safer solution on here.
// MARK: - Reddit Action Extension
extension GameDetailsViewController : GameDetailsRedditTableViewCellDelegate {
    func redditAction() {
        if let url = currentGameDetail?.reddit_url {
            UIApplication.shared.open(URL(string: url)!)
        }
    }
}

// MARK: - Website Action Extension
extension GameDetailsViewController : GameDetailsWebsiteTableViewCellDelegate {
    func websiteAction() {
        if let url = currentGameDetail?.website {
            UIApplication.shared.open(URL(string: url)!)
        }
    }
}
