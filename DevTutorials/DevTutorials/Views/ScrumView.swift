//
//  ScrumView.swift
//  DevTutorials
//
//  Created by yangjs on 2023/06/21.
//

import SwiftUI

struct ScrumView: View {
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewScrumView = false
    let saveAction: () -> Void
    
    var body: some View {
        NavigationStack{
            List($scrums) { $scrum in
                NavigationLink(
                    destination: DetailView(scrum: $scrum))
                {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button(action:{ isPresentingNewScrumView = true })
                {
                    Image(systemName: "plus")
                        
                }
                .accessibilityLabel("New Scrum")
            }
            .sheet(isPresented: $isPresentingNewScrumView){
                NewScrumSheet(isPresentingNewScrumView: $isPresentingNewScrumView, scrums: $scrums)
            }
            .onChange(of: scenePhase) { newValue in
                if newValue == .inactive{ saveAction() }
            }
        }
    }
}

struct ScrumView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumView(
            scrums: .constant( DailyScrum.sampleData),
            saveAction: {}
        )
    }
}
