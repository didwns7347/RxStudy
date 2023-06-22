//
//  ScrumView.swift
//  DevTutorials
//
//  Created by yangjs on 2023/06/21.
//

import SwiftUI

struct ScrumView: View {
    @Binding var scrums: [DailyScrum]
    @State private var isPresentingNewScrumView = false
    
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
        }
    }
}

struct ScrumView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumView(scrums: .constant( DailyScrum.sampleData))
    }
}
