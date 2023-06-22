//
//  ContentView.swift
//  DevTutorials
//
//  Created by yangjs on 2023/06/21.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum : DailyScrum
    @StateObject var scrumTier = ScrumTimer()
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .fill(scrum.theme.mainColor)
            
            VStack{
                MeetingHeaderView(secondsElapsed: 180, secondsRemaing: 60, theme: scrum.theme)
                
                Circle()
                    .strokeBorder(lineWidth: 24)
                HStack{
                    Text("Speacker 1 of 3")
                    Spacer()
                    Button(action:{}){
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
                
            }
            .padding()
            .foregroundColor(scrum.theme.accentColor)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
