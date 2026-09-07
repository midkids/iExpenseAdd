//
//  ContentView.swift
//  iExpenseAdd
//
//  Created by Myron Snelson on 9/4/26.
//
// The iExpense Add Project was created
// specifically to do the challenges in
// Project 12 (Day 59)

import SwiftUI

struct User: Codable {
    let firstName: String
    let lastName: String
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

struct ContentView: View {
    // Using @State here is just to keep the object alive
    //   It is the @Observable macro that notices changes
    //   and notifies SwiftUI views to update themselves
    // IMPORTANT: Both the ContentView and the AddView
    //   will share the same list of expense items
    @State private var expenses = Expenses()
    
    var body: some View {
        NavigationStack {
            // This is a dynamic list. SwiftUI needs to know
            // how to identify each single view
            // inside there uniquely
            // so it can tell what view has changed
            // when the data changes
            List {
                ForEach(expenses.items) {item in
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
                    AddView(expenses: expenses)
                } label: {
                    Label("Add Expense", systemImage: "plus")
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}

