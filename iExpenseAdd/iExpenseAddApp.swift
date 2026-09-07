//
//  iExpenseAddApp.swift
//  iExpenseAdd
//
//  Created by Myron Snelson on 9/4/26.
//

import SwiftData
import SwiftUI

@main
struct iExpenseAddApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expenses.self)
    }
}
