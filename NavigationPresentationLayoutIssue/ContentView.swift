//
//  ContentView.swift
//  NavigationPresentationLayoutIssue
//
//  Created by Dane Miluski on 12/9/20.
//

import SwiftUI

struct ContentView: View {

    @State
    var text: String = ""

    @State
    var isPresentingNavigation: Bool = false

    var body: some View {

        VStack {

            TextField("Enter", text: $text)
                .padding()
                .border(Color.black)

            HStack {

                Button("Show Navigation") {
                    self.isPresentingNavigation = true
                }
            }


        }
        .sheet(isPresented: $isPresentingNavigation, content: {
            NavigationView()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
