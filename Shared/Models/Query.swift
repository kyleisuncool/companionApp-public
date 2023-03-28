//
//  Query.swift
//  companionApp
//
//  Created by Kyle Joseph on 3/18/23.
//

import Foundation

struct Query: Identifiable, Hashable {
    
    let id = UUID()
    let question: String
    let answer: String
    
}
