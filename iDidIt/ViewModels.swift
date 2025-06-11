import Foundation

@MainActor
final class ListsViewModel: ObservableObject {
    @Published private(set) var lists: [ListModel] = []
    @Published var addingList = false
    
    var newListTitle = ""
    
    private let repo: TodoRepository

    init(repo: TodoRepository) {
        self.repo = repo
    }

    func load() async { lists = try! await repo.fetchLists() }

    func createList() async {
        let new = ListModel(id: .init(), title: newListTitle, items: [])
        try! await repo.save(list: new)
        await load()
    }
    
    
    
}
