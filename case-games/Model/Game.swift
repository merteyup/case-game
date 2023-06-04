//
//  Games.swift
//  case-games
//
//  Created by Eyüp Mert on 2.06.2023.
//

import Foundation


struct Game : Codable {
    
    let id: Int
    let name: String
    let background_image: String
    let metacritic: Int?
    let genres: [Genre]
    
}
