import Foundation
import SwiftUI

@MainActor
class DemoPaginationViewModel: ObservableObject {
    @Published var items: [DemoItem] = []
    @Published var isLoading = false
    @Published var isLoadingMore = false
    @Published var hasMorePages = true
    @Published var errorMessage: String?
    
    private let dataService: DemoDataServiceProtocol
    private var currentPage = 0
    private let pageSize = 10
    
    init(dataService: DemoDataServiceProtocol = DemoDataService()) {
        self.dataService = dataService
    }
    
    func loadInitialData() async {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        items = []
        currentPage = 0
        hasMorePages = true
        
        defer { isLoading = false }
        
        do {
            let response = try await dataService.fetchItems(page: 1, pageSize: pageSize)
            items = response.items
            currentPage = response.currentPage
            hasMorePages = response.hasMorePages
        } catch {
            errorMessage = "Failed to load data: \(error.localizedDescription)"
        }
    }
    
    func loadMoreData() async {
        guard !isLoadingMore && hasMorePages else { return }
        
        isLoadingMore = true
        defer { isLoadingMore = false }
        
        do {
            let nextPage = currentPage + 1
            let response = try await dataService.fetchItems(page: nextPage, pageSize: pageSize)
            items.append(contentsOf: response.items)
            currentPage = response.currentPage
            hasMorePages = response.hasMorePages
        } catch {
            errorMessage = "Failed to load more data: \(error.localizedDescription)"
        }
    }
    
    func refresh() async {
        await loadInitialData()
    }
}