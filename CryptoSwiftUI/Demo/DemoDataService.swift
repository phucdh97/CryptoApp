import Foundation

protocol DemoDataServiceProtocol {
    func fetchItems(page: Int, pageSize: Int) async throws -> PaginatedResponse<DemoItem>
}

class DemoDataService: DemoDataServiceProtocol {
    private let totalItems = 100
    private let mockDelay: TimeInterval = 1.0
    
    func fetchItems(page: Int, pageSize: Int = 10) async throws -> PaginatedResponse<DemoItem> {
        try await Task.sleep(nanoseconds: UInt64(mockDelay * 1_000_000_000))
        
        let startIndex = (page - 1) * pageSize
        let endIndex = min(startIndex + pageSize, totalItems)
        
        guard startIndex < totalItems else {
            return PaginatedResponse(
                items: [],
                currentPage: page,
                totalPages: (totalItems + pageSize - 1) / pageSize,
                hasMorePages: false
            )
        }
        
        let items = (startIndex..<endIndex).map { index in
            DemoItem(
                title: "Item #\(index + 1)",
                subtitle: "This is the description for item number \(index + 1). Page: \(page)"
            )
        }
        
        let totalPages = (totalItems + pageSize - 1) / pageSize
        
        return PaginatedResponse(
            items: items,
            currentPage: page,
            totalPages: totalPages,
            hasMorePages: page < totalPages
        )
    }
}