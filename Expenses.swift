//
//  Expenses.swift
//  iExpenseAdd
//
//  Created by Myron Snelson on 9/4/26.
//

import Foundation
import Observation

// Clases the use the observable protocol,
//  can be used in more than one SwiftUI view
//  and all of those views will be updated
//  when the relevant properties of the object changes
@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            // To correctly save our items correctly:
            // 1) make a JSON encoder
            // 2) encode the items variable
            // IMPORTANT: this encoder can only be used
            //   to encode objects that conform to the
            //   Codeable protocol - added Codeable to ExpenseItem struct
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    // custom initializer
    init() {
        // To load our items correctly:
        // 1) check to see if UserDefaults is there for key "Items"
        // 2) if it is there, try to decode the UserDefaults data
        //    into an array of ExpenseItems
        //    The .self is needed because SwiftUI needs to know
        //    we are referring to the type ExpenseItem itself
        //    That is, give me an array of ExpenseItems as a type
        // 3) store the loaded data into items property of
        //    the Expenses class
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        // If either of the two actions above fail
        // make items an empty array
        items = []
    }
}
