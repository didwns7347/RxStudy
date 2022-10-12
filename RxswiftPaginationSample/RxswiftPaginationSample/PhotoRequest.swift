//
//  PhotoRequest.swift
//  RxswiftPaginationSample
//
//  Created by yangjs on 2022/08/30.
//

import Foundation
struct PhotoRequest : Codable{
    let page :Int
    let perPage :Int = 10
    enum Codingkeys: String,CodingKey{
        case page
        case perPage = "per_page"
    }
}
extension Encodable{
    func toDictionary() -> [String:Any]{
        do{
            let jsonEncoder = JSONEncoder()
            let encodedData = try jsonEncoder.encode(self)
            let dictionaryData = try JSONSerialization.jsonObject(with: encodedData, options: .allowFragments) as? [String:Any]
            return dictionaryData ?? [:]
        }catch{
            return [:]
        }
    }
}
