//
//  Repository.swift
//  RxSearchSample
//
//  Created by yangjs on 2022/08/02.
//

import Foundation


struct Repository: Decodable {
    let id: Int
    let name: String
    let description: String
    let stargazersCount: Int
    let language: String
    let url : String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, language, url
        case stargazersCount = "stargazers_count"
    }
}
