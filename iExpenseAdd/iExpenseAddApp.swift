//
//  iExpenseAddApp.swift
//  iExpenseAdd
//
//  Created by Myron Snelson on 9/4/26.
//

import SwiftData // <- Added
import SwiftUI

@main
struct iExpenseAddApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // Step 2 - Add a model container in our
        // main project app
        .modelContainer(for: ExpenseItem.self)
    }
}
