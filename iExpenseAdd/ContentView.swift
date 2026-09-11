//
//  ContentView.swift
//  iExpenseAdd
//
//  Created by Myron Snelson on 9/4/26.
//
// The iExpense Add Project was created
// specifically to do the challenges in
// Project 12 (Day 59)

import SwiftData
import SwiftUI

struct ContentView: View {
    
    // Step 5 - access our model context
    // allows us to add things to the model context
    // easily
    @Environment(\.modelContext) var modelContext
    
    @State private var showExpenses = 0
    
    var body: some View {
        NavigationStack {
            ExpenseListView(showExpenses: showExpenses)
                .navigationTitle("iExpense")
            .toolbar {
                Menu("Expenses", systemImage: "eye") {
                    Picker("Expenses", selection: $showExpenses) {
                        Text("Show all expenses").tag(0)
                        Text("Show business expenses").tag(1)
                        Text("Show personal expenses").tag(2)
                    }
                }
                NavigationLink {
                    AddView()
                } label: {
                    Label("Add Expense", systemImage: "plus")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

