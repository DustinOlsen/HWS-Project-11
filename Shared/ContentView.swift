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
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>
    
    
    func deleteBook(at offsets: IndexSet) {
        for offset in offsets {
        // find this book in our fetch request
        let book = books[offset]
        
        // delete it from the context
        moc.delete(book)
        }
        
        // save the context
        try? moc.save()
    
    }

    @State private var showingAddBook = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Uknown Title")
                                .font(.headline)
                            Text(book.author ?? "Uknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteBook)
            }
                .navigationBarTitle("Bookworm")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
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
