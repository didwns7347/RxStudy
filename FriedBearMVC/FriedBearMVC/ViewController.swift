//
//  ViewController.swift
//  FriedBearMVC
//
//  Created by yangjs on 2022/12/15.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var datetieLabel: UILabel!
    var currentDateTime : Date = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onTomorrow(_ sender: Any) {
        print("tommorow")
        guard let tomorrow = Calendar.current.date(byAdding: .day,value: 1 ,to: currentDateTime) else{ return }
        currentDateTime = tomorrow
        updateDateTime()
    }
    
    @IBAction func onYesterday(_ sender: Any) {
        print("yesterday")
        guard let yesterday = Calendar.current.date(byAdding: .day,value: -1 ,to: currentDateTime) else{ return }
        currentDateTime = yesterday
        updateDateTime()
    }
    
    @IBAction func onNow(_ sender: Any) {
        print("Now")
        fetch()
    }
    
    func fetch(){
        let url = URL(string: "http://worldclockapi.com/api/json/utc/now")!
        let request = URLRequest(url: url)
        self.datetieLabel.text = "Loading..."
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data else { return }
            guard let model = try? JSONDecoder().decode(DataModel.self, from: data) else { return }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
            guard let now = formatter.date(from: model.currentDateTime) else { return}
            self?.currentDateTime = now
            DispatchQueue.main.async {
                self?.updateDateTime()
            }
            
            
        }.resume()
    }
    
    private func updateDateTime(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        self.datetieLabel.text = formatter.string(from: self.currentDateTime )
    }
}

struct DataModel : Decodable{
    let id : String
    let currentDateTime : String
    let utcOffset : String
    let isDayLightSavingsTime:  Bool
    let dayOfTheWeek : String
    let timeZoneName:String
    let currentFileTime: Int
    let ordinalDate : String
    let serviceResponse: String?
    enum CodingKeys:String, CodingKey {
        case id = "$id"
        case currentDateTime
        case utcOffset
        case isDayLightSavingsTime
        case dayOfTheWeek
        case timeZoneName
        case currentFileTime
        case ordinalDate
        case serviceResponse
    }
    
}
/*
 JSON
 서버 모델 -> Entitiy
 -> DataModel
 //-> String
 
 MODEL
 -> Date
 
 화면 모델 -> ViewModel
 -> STring
 
 

 */
