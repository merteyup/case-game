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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
    }
    
}


extension GameDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GameDetailsImageTableViewCellID") as! GameDetailsImageTableViewCell
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GameDetailsDescriptionTableViewCellID") as! GameDetailsDescriptionTableViewCell
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GameDetailsRedditTableViewCellID") as! GameDetailsRedditTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GameDetailsWebsiteTableViewCellID") as! GameDetailsWebsiteTableViewCell
            return cell
        }
        
    }
    
 
    
    
    
    
    
}
