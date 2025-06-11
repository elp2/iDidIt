import Foundation
import SwiftUI

struct ListsView: View {
    @StateObject var vm = ListsViewModel(repo: LocalTodoRepository())

    var body: some View {
        NavigationStack {
            List(vm.lists) { list in
                NavigationLink(list.title) { ListView(listID: list.id) }
            }
            .navigationTitle("Lists")
            .toolbar {
                Button { vm.addingList = true } label: { Image(systemName: "plus") }
            }
        }
        .task { await vm.load() }
        .sheet(isPresented: $vm.addingList) { NewListSheet(vm: vm) }
    }
}

struct NewListSheet: View {
    @ObservedObject var vm: ListsViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                TextField("List Name", text: $vm.newListTitle)
                Button("Create") {
                    Task {
                        await vm.createList()
                        dismiss()
                    }
                }
            }
            .navigationTitle("New List")
        }
    }
}
