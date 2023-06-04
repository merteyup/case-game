//
//  GetAllGamesResponse.swift
//  case-games
//
//  Created by Eyüp Mert on 2.06.2023.
//

import Foundation


struct GetAllGamesResponse: Codable {
    
    let results: [Game]
    let next: String?
    let previous: String?
    
}
