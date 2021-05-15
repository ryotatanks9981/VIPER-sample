//
//  ArticleEntity.swift
//  VIPER-sample
//
//  Created by Ryota Karita on 2021/05/11.
//

import Foundation

struct RepositoryEntity: Decodable {
    let id: Int
    let name: String
    let fullName: String
    let htmlURL: URL
    let starCount: Int
    let owner: UserEntity
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case htmlURL = "html_url"
        case starCount = "stargazers_count"
        case owner
    }
}
