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

struct User: Codable {
    let firstName: String
    let lastName: String
}

struct ContentView: View {
    
    // Step 5 - access our model context
    // allows us to add things to the model context
    // easily
    @Environment(\.modelContext) var modelContext
    
    // query of all our expense items sorted by name
    @Query(sort: \ExpenseItem.name) var items: [ExpenseItem]
    
    var body: some View {
        NavigationStack {
            // This is a dynamic list. SwiftUI needs to know
            // how to identify each single view
            // inside there uniquely
            // so it can tell what view has changed
            // when the data changes
            List {
                ForEach(items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .foregroundStyle(item.amount <= 10 ? .green : (item.amount >= 11 && item.amount <= 99 ? .yellow : .red))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddView()
                } label: {
                    Label("Add Expense", systemImage: "plus")
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            modelContext.delete(items[offset])
        }
    }
}

#Preview {
    ContentView()
}

