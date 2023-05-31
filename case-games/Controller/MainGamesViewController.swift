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
    
    
    // MARK: - Statements
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

  
    
}


    // MARK: - TableViewExtension
extension MainGamesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainGamesTableViewCellID") as! MainGamesTableViewCell
        
        
        return cell
    }
    
    
}
