//
//  History.swift
//  DevTutorials
//
//  Created by yangjs on 2023/06/22.
//

import Foundation

struct History: Identifiable ,Codable{
    let id : UUID
    let date : Date
    var attendees: [DailyScrum.Attendee]
    var transcript : String?
    
    var attendeesString : String {
        attendees.reduce("") {$0 + "\($1.name), "}
    }
    
    init(id: UUID = UUID(), date: Date = Date(), attendees: [DailyScrum.Attendee],transcript: String? = nil) {
        self.id = id
        self.date = date
        self.attendees = attendees
        self.transcript = transcript
    }
}
