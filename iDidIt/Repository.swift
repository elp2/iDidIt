import Foundation

protocol TodoRepository {
    func fetchLists() async throws -> [ListModel]
    func save(list: ListModel) async throws
    func delete(listID: UUID) async throws
    func save(item: ItemModel, in listID: UUID) async throws
}

class LocalTodoRepository: TodoRepository {
    var lists = [] as [ListModel]

    func fetchLists() async throws -> [ListModel] {
        return lists
    }

    func save(list: ListModel) async throws {
        if let index = lists.firstIndex(where: { $0.id == list.id }) {
            lists[index] = list
        } else {
            lists.append(list)
        }
    }
    
    func delete(listID: UUID) async throws {
        lists.removeAll { $0.id == listID }
    }
    
    func save(item: ItemModel, in listID: UUID) async throws {
        if var list = list(with: listID) {
            if let index = list.items.firstIndex(where: { $0.id == item.id }) {
                list.items[index] = item
            } else {
                list.items.append(item)
            }
        } else {
            throw NSError(domain: "List not found", code: 404)
        }
    }

    private func list(with id: UUID) -> ListModel? {
        return lists.first { $0.id == id }
    }
}
