//
//  ViewController.swift
//  case-games
//
//  Created by Eyüp Mert on 31.05.2023.
//

import UIKit

class MainGamesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables

    var allLoadedGames = [Game]()
    
    // MARK: - Statements
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        getAllGames()
        
    }

    // MARK: - Functions
    
    /// Function that brings current games and show on table view.
    fileprivate func getAllGames() {
        /// Use api service to get accessible games.
        Service.shared.execute(.listGamesRequest, expecting: GetAllGamesResponse.self) { result in
            switch result {
            case .success(let model):
                self.allLoadedGames = model.results
            case .failure(let error):
                print(String(describing: error))
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
  }


    // MARK: - TableViewExtension
extension MainGamesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allLoadedGames.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainGamesTableViewCellID") as! MainGamesTableViewCell
       
        let game = allLoadedGames[indexPath.row]
        cell.updateCell(currentGame: game)
        
        return cell
    }
    
}
