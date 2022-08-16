//
//  MySection.swift
//  RxdatasourceTableView
//
//  Created by yangjs on 2022/08/16.
//
import RxDataSources
import Foundation
struct MySection{
    var headerTitle: String
    var items:[Item]
    
}
extension MySection : AnimatableSectionModelType{
    typealias Item = MyModel
    
    var identity: String{
        return headerTitle
    }
    
    init(original: MySection, items:[MyModel]){
        self = original
        self.items = items
    }
}
