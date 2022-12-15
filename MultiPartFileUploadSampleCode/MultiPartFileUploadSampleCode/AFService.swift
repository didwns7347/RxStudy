//
//  AFService.swift
//  MultiPartFileUploadSampleCode
//
//  Created by yangjs on 2022/11/15.
//

//import Foundation
import Alamofire
import UIKit
struct AFService {
    
    static let shared = AFService()
    let images = [UIImage(named: "fig"), UIImage(named: "lime"), UIImage(named: "strawberry"), UIImage(named: "watermelon")]
    func editActivity (imageData: UIImage?
                            ) {
        
        let URL = "http://112.171.104.167:58081/blamarket-0.0.1-SNAPSHOT-plain/post/write"
        let header : HTTPHeaders = [
            "Content-Type" : "multipart/form-data"
          ]
        
        let parameters: [String : Any] = [
            "email": "didwns7347@naver.com",
            "contents": "불꼬추준수로",
            "title": "양자역학",
            "price": 10000,
            "companyId": 1,
            "category":1
        ]
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                print("\(key): \(value)")
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
//            print(String(data: try! multipartFormData.encode() , encoding: .utf8))
//            print(imageData?.pngData()?.count/1024)
            for img in images{
                if let image = img?.pngData() {
                    print(image.count/1024)
                    multipartFormData.append(image, withName: "imageList", fileName: "\(image).png", mimeType: "image/png")
                }
                
            }
            //print(String(data: try! multipartFormData.encode() , encoding: .utf8))
        }, to: URL, usingThreshold: UInt64.init(), method: .post, headers: header).response { response in
            guard let statusCode = response.response?.statusCode,
                  statusCode == 200
                    
            else { return }
            print(response.request?.httpBody?.incodingHTML())
            print(response.response?.statusCode)
            print(response.response)
       
        }
    }
}
