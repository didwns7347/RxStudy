//
//  DetailDditView.swift
//  DevTutorials
//
//  Created by yangjs on 2023/06/21.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var scrum : DailyScrum
    @State private var newAttendeeName = ""
    
    var body: some View {
        Form {
            Section(
                content: {
                    TextField("title", text: $scrum.title)
                    HStack {
                        Slider(value: $scrum.lengthInMinutesAsDouble, in: 5...30, step: 1){
                            Text("Length")
                        }
                        Spacer()
                        Text("\(scrum.lengthInMinutes) minutes")
                    }
                    ThemePicker(selection: $scrum.theme)
                },
                header: {Text("Meeting Info")}
            )
            
            Section(
                content: {
                    ForEach(scrum.attendees) { attendee in
                        Text(attendee.name)
                    }
                    .onDelete{ indices in
                        scrum.attendees.remove(atOffsets: indices)
                    }
                    HStack {
                        TextField("New Attendee", text: $newAttendeeName)
                        Button(action: {
                            withAnimation {
                                let attendee = DailyScrum.Attendee(name: newAttendeeName)
                                scrum.attendees.append(attendee)
                                newAttendeeName = ""
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .accessibilityLabel("Add attendee")
                        }
                        .disabled(newAttendeeName.isEmpty)
                    }
                },
                header: {Text("Attendees")}
            )
        }
    }
}

struct DetailDditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
