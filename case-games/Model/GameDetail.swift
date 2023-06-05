//
//  GameDetail.swift
//  case-games
//
//  Created by Eyüp Mert on 5.06.2023.
//

import Foundation


struct GameDetail : Codable {
    
    let id: Int?
    let name: String?
    let description_raw: String?
    let background_image: String?
    let website: String?
    let reddit_url: String?
    
}
