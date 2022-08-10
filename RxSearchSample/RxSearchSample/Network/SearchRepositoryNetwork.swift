//
//  SearchRepositoryNetwork.swift
//  SearchDaumBlog
//
//  Created by yangjs on 2022/08/02.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
enum NetworkError : Error{
    case invalidURL
    case invalidJSON
    case networkError
}


class SearchRepositoryNetwork{
    func searchRepository(query:String)-> Single<Result<[Repository],NetworkError>>{
        guard let url = URL(string:"https://api.github.com/users/\(query)/repos") else{
            return .just(.failure(.invalidURL))
        }
        var request = URLRequest(url: url)
        request.method = .get
        let session = URLSession.shared
        return session.rx.data(request: request)
            .map{ data -> Result<[Repository], NetworkError> in
                do{
                    let repo = try JSONSerialization.jsonObject(with: data) as? [[String:Any]]
                    let result = repo?.map({ dict -> Repository in
                        let id = dict["id"] as? Int
                        let name = dict["name"] as? String
                        let fullName = dict["full_name"] as? String
                        let stargazersCount = dict["stargazers_count"] as? Int
                        let language = dict["language"] as? String
                        let url = dict["html_url"] as? String
                        return Repository(id: id ?? 0 ,
                                          name: name ?? "오류",
                                          description: fullName ?? "오류",
                                          stargazersCount: stargazersCount ?? 0,
                                          language: language ?? "오류",
                                          url: url ?? ""
                        )
                        
                    })
                    return .success(result ?? [])
                    
                }catch{
                    return .failure(.invalidJSON)
                }
            }
            .catch{ _ in
                    .just(.failure(.networkError))
            }
            .asSingle()
    }
}

