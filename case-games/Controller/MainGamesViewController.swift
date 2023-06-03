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
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Variables
    private var allLoadedGames = [Game]()
    private var filteredGames = [Game]()
    
    
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
                /// Set filtered games from all loaded games for search usage.
                self.filteredGames = self.allLoadedGames
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
        return filteredGames.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainGamesTableViewCellID") as! MainGamesTableViewCell
        
        let game = filteredGames[indexPath.row]
        cell.updateCell(currentGame: game)
        
        return cell
    }
    
}

// MARK: - SearchBar Extension

extension MainGamesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredGames = allLoadedGames
        if searchText.count >= 3 {
            /// Filter games if search text count is equal or greater than 3 and reload table view for searched games.
            filteredGames = allLoadedGames.filter { $0.name.localizedCaseInsensitiveContains(searchText)}
            self.tableView.reloadData()
        } else {
            /// Reload table view data only if text count is less than 3 and text is clear.
            if searchText == "" {
                self.tableView.reloadData()
            }
        }
    }
    
    
}
