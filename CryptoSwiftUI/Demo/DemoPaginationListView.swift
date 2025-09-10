//
//  DemoPaginationListView.swift
//  CryptoSwiftUI
//
//  Created by Do Huu Phuc on 10/9/25.
//

import SwiftUI

struct DemoPaginationListView: View {
    @StateObject private var viewModel = DemoPaginationViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading && viewModel.items.isEmpty {
                    VStack {
                        ProgressView()
                        Text("Loading...")
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let errorMessage = viewModel.errorMessage, viewModel.items.isEmpty {
                    VStack {
                        Text("Error")
                            .font(.headline)
                        Text(errorMessage)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button("Retry") {
                            Task {
                                await viewModel.loadInitialData()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.items) { item in
                                DemoItemView(item: item)
                                    .onAppear {
                                        if item == viewModel.items.last && viewModel.hasMorePages && !viewModel.isLoadingMore {
                                            Task {
                                                await viewModel.loadMoreData()
                                            }
                                        }
                                    }
                            }
                            
                            if viewModel.isLoadingMore {
                                HStack {
                                    ProgressView()
                                        .scaleEffect(0.8)
                                    Text("Loading more...")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                .padding()
                            } else if !viewModel.hasMorePages && !viewModel.items.isEmpty {
                                Text("No more items")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .padding()
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                    }
                    .refreshable {
                        await viewModel.refresh()
                    }
                }
            }
            .navigationTitle("Pagination Demo")
            .task {
                if viewModel.items.isEmpty {
                    await viewModel.loadInitialData()
                }
            }
        }
    }
}

struct DemoItemView: View {
    let item: DemoItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(item.subtitle)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                }
                
                Spacer()
                
                Text(item.createdAt, style: .time)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    DemoPaginationListView()
}
