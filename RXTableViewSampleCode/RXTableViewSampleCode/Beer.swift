//
//  Beer.swift
//  RXTableViewSampleCode
//
//  Created by yangjs on 2022/10/20.
//

import Foundation


struct Beer: Decodable{
    let id :Int?
    let name:String?
    let taglineString:String?
    let description:String?
    let brewersTips:String?
    let imageURL :String?
    let foodParing: [String]?
    
    var tagLine :String{
        let tags = taglineString?.components(separatedBy: ". ")
        let hashTags = tags?.map{
            "#" + $0.replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: ".", with: "")
                .replacingOccurrences(of: ",", with: " #")
        }
        return hashTags?.joined(separator: " ") ?? ""
    }
    
    enum CodingKeys: String, CodingKey{
        case id,name, description
        case taglineString = "tagline"
        case imageURL = "image_url"
        case brewersTips = "brewers_tips"
        case foodParing = "food_pairing"
    }

}
/*
 {
 "id": 1,
 "name": "Buzz",
 "tagline": "A Real Bitter Experience.",
 "first_brewed": "09/2007",
 "description": "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.",
 "imageURL": "https://images.punkapi.com/v2/keg.png",
 "abv": 4.5,
 "ibu": 60,
 "target_fg": 1010,
 "target_og": 1044,
 "ebc": 20,
 "srm": 10,
 "ph": 4.4,
 "attenuation_level": 75,
 "volume": {},
 "boil_volume": {},
 "method": {},
 "ingredients": {},
 "food_pairing": [],
 "brewers_tips": "The earthy and floral aromas from the hops can be overpowering. Drop a little Cascade in at the end of the boil to lift the profile with a bit of citrus.",
 "contributed_by": "Sam Mason <samjbmason>"
 },
 */
extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
