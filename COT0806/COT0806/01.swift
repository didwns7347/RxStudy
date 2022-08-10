////
////  01.swift
////  COT0806
////
////  Created by yangjs on 2022/08/06.
////
//
//import Foundation
//
//print("Hello, World!")
//let input = [["2022-06-24T23:57:42", "정원", "민탁님"], ["2022-06-24T23:57:44", "정원", "생일이 얼마 안남으셨네요"], ["2022-06-24T23:57:54", "정원", "소감 한말씀 부탁드립니닼ㅋㅋㅋ"], ["2022-06-24T23:58:02", "금상", "오~ 민탁님 내일 생일이세요? 축하해요!"], ["2022-06-24T23:58:05", "민탁", "으악 감사해요 이렇게 늦은저녁까지 챙겨주시고ㅠㅠ!"], ["2022-06-24T23:58:34", "도현", "민탁님 축하드려요~~!"], ["2022-06-24T23:58:36", "도현", ""], ["2022-06-24T23:58:55", "금상", "민탁님"], ["2022-06-24T23:59:01", "금상", "생일기념 내일 뭐하시나요~"], ["2022-06-24T23:59:10", "정원", "가족과 여행?"], ["2022-06-24T23:59:12", "금상", "해외여행 가시는건가요!!"], ["2022-06-24T23:59:55", "민탁", "일주일쉬면서 가족하고 하와이갑니다~~ 축하감사해요 모두!"], ["2022-06-25T00:00:01", "정원", "이제 진짜 생일되셨네요!! 축하합니다!!"], ["2022-06-25T00:01:05", "민탁", ""]]
//
//struct Message {
//    
//    let time:Date
//    let name:String
//    let msg:String
// 
//    let dateString:String
//    let outputdate : String
//    init(dateString:String, name:String, msg:String)
//    {
//        let dateFormater = DateFormatter()
//        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let outdateFormatter = DateFormatter()
//        outdateFormatter.dateFormat = "-- yyyy-MM-dd --"
//        let formatter = DateFormatter()
//        formatter.dateFormat = "(HH:mm)"
//        let dstring = dateString.replacingOccurrences(of: "T", with: " ")
//        let convertDate = dateFormater.date(from: dstring)
//        self.time = convertDate!
//        self.name = "[\(name)]"
//        self.msg = msg == "" ? "<삭제된 메시지>":msg
//        self.dateString = outdateFormatter.string(from: convertDate!)
//        self.outputdate = formatter.string(from: convertDate!)
//    }
//}
//func solution(_ messages:[[String]]) -> [String] {
//    var list = [Message]()
//    var answer = [String]()
//    for message in messages {
//        let msg = Message(dateString: message[0], name: message[1], msg: message[2])
//        list.append(msg)
//        //print(msg.time,msg.name,msg.msg,msg.outputdate)
//    }
//    var lastmsg : Message? = nil
//   
//    for msg in list{
//        if let tmp = lastmsg {
//            if tmp.dateString != msg.dateString{
//                answer.append(tmp.outputdate)
//                answer.append(msg.dateString)
//                answer.append(msg.name)
//                answer.append(msg.msg)
//                lastmsg = msg
//                continue
//            }
//            else if tmp.name == msg.name, tmp.outputdate == msg.outputdate{
//                answer.append(msg.msg)
//                lastmsg = msg
//            }
//            else{
//                answer.append(tmp.outputdate)
//                answer.append(msg.name)
//                answer.append(msg.msg)
//                lastmsg = msg
//            }
//        }
//        else{
//            lastmsg = msg
//            answer.append(msg.name)
//            answer.append(msg.msg)
//        }
//    }
//    if let lastmsg = lastmsg {
//        answer.append(lastmsg.outputdate)
//    }
//   
//    return answer
//    
//}
//solution(input)
