//
//  SearchResponseEntity.swift
//  VIPER-sample
//
//  Created by Ryota Karita on 2021/05/13.
//

import Foundation

struct SearchResponseEntity<Item: Decodable>: Decodable {
    let totalCount: Int
    let items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
