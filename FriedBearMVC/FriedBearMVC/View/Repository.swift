//
//  Logic.swift
//  FriedBearMVC
//
//  Created by yangjs on 2022/12/15.
//

import Foundation
class Repository{
    //Entity -> Model
    func fetchNow(onComplete: @escaping (Entity) -> Void){
        let url = URL(string: "http://worldclockapi.com/api/json/utc/now")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) {  data, _, _ in
            guard let data = data else { return }
            guard let model = try? JSONDecoder().decode(Entity.self, from: data) else{
                return
            }
            onComplete(model)
            
            
        }.resume()
    }
}
