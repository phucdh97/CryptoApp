import Foundation

struct DemoItem: Identifiable, Hashable {
    let id: UUID
    let title: String
    let subtitle: String
    let createdAt: Date
    
    init(title: String, subtitle: String) {
        self.id = UUID()
        self.title = title
        self.subtitle = subtitle
        self.createdAt = Date()
    }
}

struct PaginatedResponse<T> {
    let items: [T]
    let currentPage: Int
    let totalPages: Int
    let hasMorePages: Bool
}