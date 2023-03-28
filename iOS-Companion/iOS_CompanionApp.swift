//
//  iOS_CompanionApp.swift
//  iOS-Companion
//
//  Created by Kyle Joseph on 3/18/23.
//

import SwiftUI

@main
struct iOS_CompanionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Model())
                .environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
        }
    }
}
