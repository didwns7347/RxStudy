//
//  MeetingHeaderView.swift
//  DevTutorials
//
//  Created by yangjs on 2023/06/22.
//

import SwiftUI

struct MeetingHeaderView: View {
    let secondsElapsed: Int
    let secondsRemaing: Int
    let theme: Theme
    
    private var totoalSeconds: Int {
        secondsRemaing + secondsElapsed
    }
    
    private var progress: Double {
        guard totoalSeconds > 0 else {
            return 1
        }
        return Double(secondsElapsed) / Double(totoalSeconds)
    }
    
    private var minutesRemaing : Int {
        secondsRemaing / 60
    }
    
    var body: some View {
        VStack{
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(theme: theme))
            
            HStack{
                VStack(alignment:.leading){
                    Text("Seconds Elapsed")
                    Label("\(secondsElapsed)", systemImage:  "hourglass.tophalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing){
                    Text("Seconds Remaining")
                    Label("\(secondsRemaing)", systemImage: "hourglass.bottomhalf.fill")
                        .labelStyle(.trailingIcon)
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time remaining")
        .accessibilityValue("\(minutesRemaing) minuates")
        .padding([.top,.horizontal])
    }
}

struct MeetingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingHeaderView(secondsElapsed: 60, secondsRemaing: 180, theme: .bubblegum)
                .previewLayout(.sizeThatFits)
    }
}
