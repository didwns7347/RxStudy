//
//  ScrumTimer.swift
//  DevTutorials
//
//  Created by yangjs on 2023/06/22.
//

import Foundation

@MainActor
final class ScrumTimer: ObservableObject {
    /// A struct to keep track of meeting attendees during a meeting
    struct Speaker : Identifiable {
        let name : String
        let isCompleted: Bool
        let id = UUID()
    }
    ///미팅 참가자중 말하고 있는사람 이름
    @Published var activeSpeaker = ""
    ///미팅이 시작한 이후로 경과된 시간초
    @Published var secondsElapsed = 0
    ///남은 시간
    @Published var secondsRemaining = 0
    /// 모든 미팅 참가자 리스트 private(set) 은 외부 리드온리로 사용가능함.
    private(set) var speakers: [Speaker] = []
    
    
    ///미팅 시간
    private(set) var lengthInMinutes : Int
    /// 새로운 참가자가 말할때 호출되는 클로저이다.
    var speakerChangeAction : (() -> Void)?
    
    private weak var timer : Timer?
    private var timerStopped = false
    private var frequency : TimeInterval { 1.0 / 60.0 }
    private var lengthInSeconds : Int { lengthInMinutes * 60 }
    private var secondsPerSpeaker: Int {
        (lengthInMinutes * 60) / speakers.count
    }
    private var secondsElapsedForSpeacker : Int = 0
    private var speakerIndex : Int = 0
    private var speakerText : String {
        return "Speaker \(speakerIndex + 1): " + speakers[speakerIndex].name
    }
    private var startDate : Date?
    
    /**
     Initialize a new timer. Initializing a time with no arguments creates a ScrumTimer with no attendees and zero length.
     Use `startScrum()` to start the timer.
     
     - Parameters:
     - lengthInMinutes: The meeting length.
     -  attendees: A list of attendees for the meeting.
     */
    init(lengthInMinutes: Int = 0, attendees: [DailyScrum.Attendee] = []) {
        self.lengthInMinutes = lengthInMinutes
        self.speakers = attendees.speakers
        secondsRemaining = lengthInSeconds
        activeSpeaker = speakerText
    }
    
    /// Start the timer
    func startScrum() {
        self.timer = 
    }
}



extension Array<DailyScrum.Attendee> {
    var speakers: [ScrumTimer.Speaker] {
        if isEmpty {
            return [ScrumTimer.Speaker(name: "Speaker 1", isCompleted: false)]
        } else {
            return map { ScrumTimer.Speaker(name: $0.name, isCompleted: false) }
        }
    }
}
