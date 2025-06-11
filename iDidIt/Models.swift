import Foundation

struct ItemModel: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var description: String
    var isDone: Bool
    var modifiedAt: Date
}

struct ListModel: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var items: [ItemModel]
}
