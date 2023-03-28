//
//  String+Extensions.swift
//  companionApp
//
//  Created by Kyle Joseph on 3/18/23.
//

import Foundation

extension String {
    
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
