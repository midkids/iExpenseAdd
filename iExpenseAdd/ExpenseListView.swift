//
//  ExpenseListView.swift
//  iExpenseAdd
//
//  Created by Myron Snelson on 9/4/26.
//

import SwiftData
import SwiftUI

struct ExpenseListView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var items: [ExpenseItem]
    
    init(showExpenses: Int) {
        let predicate: Predicate<ExpenseItem>?
        
        switch showExpenses {
        case 1:
            predicate = #Predicate<ExpenseItem> { item in
                item.type == "Business"
            }
        case 2:
            predicate = #Predicate<ExpenseItem> { item in
                item.type == "Personal"
            }
        default:
            predicate = nil
        }
        // _items is the underlying property-wrapper storage
        
        // IMPORTANT: _items does not refer to the users
        // array
        // Rather the underscore indicates to Swift
        // we are not trying to change the items array,
        // but instead we are trying to change the
        // underlying SwiftData query that produces
        // the items array
        // We will be making a new query here from the
        // items data being passed in
        // In other words, this query does not replace the
        // [ExpenseItem] array directly
        // It configures the SwiftData query that
        // will produce the items array
        
        _items = Query(filter: predicate, sort: \ExpenseItem.name)
    }
    
    var body: some View {
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
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            modelContext.delete(items[offset])
        }
    }
}
