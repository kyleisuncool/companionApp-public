//
//  ContentView.swift
//  macOS-Companion
//
//  Created by Kyle Joseph on 3/18/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            HistoryView()
        } detail: {
            MainView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
