//
//  Model.swift
//  companionApp
//
//  Created by Kyle Joseph on 3/18/23.
//
// Aggregate Model

import Foundation

class Model: ObservableObject {
    
    @Published var queries: [Query] = []
    @Published var query = Query(question: "", answer: "")
    
    func saveQuery(_ query: Query) throws {
        
        let viewContext = CoreDataManager.shared.persistentContainer.viewContext
        let historyItem = HistoryItem(context: viewContext)
        historyItem.question = query.question
        historyItem.answer = query.answer
        historyItem.dateCreated = Date()
        try viewContext.save()
        
    }
    
}
