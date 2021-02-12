//
//  ContentView.swift
//  Shared
//
//  Created by Dustin Olsen on 2/11/21.
//

import SwiftUI
import CoreData




struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>

    @State private var showingAddBook = false
    
    var body: some View {
        NavigationView {
            Text("Count: \(books.count)")
                .navigationBarTitle("Bookworm")
                .navigationBarItems(trailing: Button(action: {
                    self.showingAddBook.toggle()
                }) {
                    Image(systemName: "plus")
                })
                .sheet(isPresented: $showingAddBook) {
                    AddBookView().environment(\.managedObjectContext, self.moc)
                    
                }
        }

    

    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
