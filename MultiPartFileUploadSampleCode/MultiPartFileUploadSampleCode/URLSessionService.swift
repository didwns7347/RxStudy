//
//  URLSessionService.swift
//  MultiPartFileUploadSampleCode
//
//  Created by yangjs on 2022/11/15.
//

import UIKit
struct URLSessionService{
    let images = [UIImage(named: "fig"), UIImage(named: "lime"), UIImage(named: "strawberry"), UIImage(named: "watermelon")]
    let url = "http://112.171.104.167:58081/blamarket-0.0.1-SNAPSHOT-plain/post/write"
    func requestIdentify() {

        let boundary = generateBoundaryString()
        let body: [String: Any] = [
            "email": "didwns7347@naver.com",
            "contents": "갈비찜을 밥위에 얹어주세요 갈비찜을 밥에다 비벼주세요 내가제일 좋아하는 갈비찜덮밥 아아아아아아 얌얌",
            "title": "TEST Post HAHAHA",
            "price": 10000,
            "companyId": 1,
            "category":1
        ]
        let bodyData = createBody(parameters: body, images: images, boundary: UUID().uuidString)
        let url = URL(string: self.url)!
        var request = URLRequest(url: url)
   
//        request.headers = [   "Content-Type" : "multipart/form-data; boundary=\(generateBoundaryString())"]
        request.setValue( "multipart/form-data; boundary=\(generateBoundaryString())", forHTTPHeaderField: "Content-Type")
        request.method = .post
        
       // bodyData
       // bodyData.flatMap{String(data: $0, encoding: .utf8)} ?? ""
        print(request.httpBody?.count)
        let session = URLSession.shared
        
        session.dataTask(with: request) { data, response, error in
            if let error = error{
                print(error)
            }else{
                let msg = data.flatMap{String(data: $0, encoding: .utf8)} ?? ""
                print(msg)
            }
        }.resume()
    }
    /**
     Optional("--alamofire.boundary.f1a416d765b8e2aa\r\nContent-Disposition: form-data; name=\"price\"\r\n\r\n10000\r\n--alamofire.boundary.f1a416d765b8e2aa\r\nContent-Disposition: form-data; name=\"companyId\"\r\n\r\n1\r\n--alamofire.boundary.f1a416d765b8e2aa\r\nContent-Disposition: form-data; name=\"category\"\r\n\r\n1\r\n--alamofire.boundary.f1a416d765b8e2aa\r\nContent-Disposition: form-data; name=\"email\"\r\n\r\ndidwns7347@naver.com\r\n--alamofire.boundary.f1a416d765b8e2aa\r\nContent-Disposition: form-data; name=\"contents\"\r\n\r\nhello my name is FireJS\r\n--alamofire.boundary.f1a416d765b8e2aa\r\nContent-Disposition: form-data; name=\"title\"\r\n\r\nTEST Post HAHAHA\r\n--alamofire.boundary.f1a416d765b8e2aa--\r\n")
     */
    private func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
    func createBody(parameters: [String:Any], images:[UIImage?],boundary:String)->Data{
        var body = Data()
        let boundaryPrefix = "--\(boundary)\r\n"
//        print(boundaryPrefix)
        for (key, value) in parameters {
            body.append(boundaryPrefix.data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        //print(String(data: body, encoding: .utf8))

        var count = 1
        for image in images {
            print(image?.pngData()?.count ?? "NO DATA")
            guard let image = image ,let pngData = image.pngData() else{continue}
            body.append(boundaryPrefix.data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"imageList\"; filename=\"images\(count).png\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
            body.append(pngData )
            body.append("\r\n".data(using: .utf8)!)
            count += 1
        }
               

        body.append(boundaryPrefix.data(using: .utf8)!)
        print(body.incodingHTML())
        return body
    }
    
    
}
