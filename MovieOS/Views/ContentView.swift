//
//  ContentView.swift
//  MovieOS
//
//  Created by Tornelius Broadwater, Jr on 12/10/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var manager: Manager
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .onAppear {
            manager.fetchMovie(id: "436270")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Manager())
    }
}
