//
//  Photo.swift
//  RxswiftPaginationSample
//
//  Created by yangjs on 2022/08/30.
//

import Foundation
struct Photo: Codable{
    struct Urls:Codable{
        let raw, full, regular, small:String
        let thumb:String
    }
    let id : String
    let width, height: Int
    let urls : Urls
}

extension Photo: Equatable{
    var urlString : String{self.urls.regular}
    static func == (lhs: Photo, rhs: Photo)-> Bool{
        lhs.id == rhs.id
    }
}
