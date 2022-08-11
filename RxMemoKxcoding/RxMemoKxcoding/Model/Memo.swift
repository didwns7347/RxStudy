//
//  Memo.swift
//  RxMemoKxcoding
//
//  Created by yangjs on 2022/08/10.
//

import Foundation
struct Memo: Equatable{
    var content : String
    var insertDate : Date
    var identity: String
    
    init(content: String, insertDate : Date = Date()){
        self.content = content
        self.insertDate = insertDate
        self.identity = "\(insertDate.timeIntervalSinceReferenceDate)"
    }
    
    init(origin: Memo, updatedContent : String){
        self = origin
        self.content = updatedContent
    }
}
