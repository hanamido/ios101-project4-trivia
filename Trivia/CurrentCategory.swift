//
//  CurrentCategory.swift
//  Trivia
//
//  Created by Hanami Do on 10/7/23.
//

import Foundation

struct CurrentCategory: Decodable {
    let id: Int
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

// stores the API response, since the data we need is in the key <name>
struct CategoriesAPIResponse: Decodable {
    let triviaCategories: [CurrentCategory]
    
    private enum CodingKeys: String, CodingKey {
        case triviaCategories = "trivia_categories"
    }
}
