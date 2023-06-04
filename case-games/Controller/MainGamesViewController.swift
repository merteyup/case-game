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
    private var apiNextPage : String?
    private var isSearching = false
    
    
    // MARK: - Statements
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// Reload table view and show tapped content's background color different than initial state.
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        /// If user scrolls or taps anywhere, hide keyboard if its open.
        self.hideKeyboardWhenTappedAround()

        getGames()
    }
    
    // MARK: - Functions
    
    /// Function that brings current games and show on table view.
    fileprivate func getGames() {
        /// Use api service to get accessible games.
        Service.shared.execute(.listGamesRequest, expecting: GetAllGamesResponse.self) { result in
            switch result {
            case .success(let model):
                self.allLoadedGames = model.results
                if let nextPage = model.next {
                    self.apiNextPage = nextPage
                }
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
    
    /// Function that brings additional games and append them in to current ones.
    /// - Parameter url: URL from JSON which shows next page of content.
    fileprivate func getAdditionalGames(url: URL) {
        /// Create request with next page url.
        guard let request = Request(url: url) else {
            return
        }
        /// Execute the request and if success append content to current ones.
        Service.shared.execute(request,
                               expecting: GetAllGamesResponse.self) { result in
            switch result {
            case .success(let success):
                self.filteredGames.append(contentsOf: success.results)
                self.apiNextPage = success.next
            case .failure(let failure):
                print(String(describing: failure))
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        /// Check is user currently searching. If not, prepare for request next page.
        if !isSearching {
            /// If user sees last cell of table view, get next page url and get additional games.
            if filteredGames.count == indexPath.row + 1 {
                guard let nextUrlString = apiNextPage, let url = URL(string: nextUrlString) else {
                    return
                }
                getAdditionalGames(url: url)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// Set tapped content as a viewed.
        filteredGames[indexPath.row].isViewed = true
        /// Perform segue to the detail page.
        performSegue(withIdentifier: "openGameDetails", sender: nil)
    }
    
}

// MARK: - SearchBar Extension

extension MainGamesViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
        resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        filteredGames = allLoadedGames
        if searchText.count >= 3 {
            /// Filter games if search text count is equal or greater than 3 and reload table view for searched games.
            filteredGames = allLoadedGames.filter { $0.name.localizedCaseInsensitiveContains(searchText)}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } else {
            /// Reload table view data only if text count is less than 3 and text is clear.
            if searchText == "" {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
