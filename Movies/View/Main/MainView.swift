//
//  MainView.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @State var hasPerformedSearch = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                List(viewModel.shows) { show in
                    NavigationLink(destination: DetailView(show: show)) {
                        ShowRowView(show: show)
                            .onAppear {
                                if show.id == viewModel.shows.last?.id {
                                    viewModel.loadMoreContentIfNeeded(currentItem: show)
                                }
                            }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .listStyle(GroupedListStyle())
                .navigationTitle("Shows")
                .searchable(text: $viewModel.searchText)
                .onSubmit(of: .search, getShowsFromSearch)
                .onChange(of: viewModel.searchText) { _ in
                    if viewModel.searchText.isEmpty && hasPerformedSearch {
                        viewModel.page = 0
                        viewModel.getShows()
                        hasPerformedSearch = false
                    }
                }
                
            }
            
            if viewModel.isLoadingPage {
                ProgressView("Progress…")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray.opacity(0.85))
                    .progressViewStyle(.circular)
            }
        }
    }
    
    func getShowsFromSearch() {
        hasPerformedSearch = true
        viewModel.getShows(with: viewModel.searchText)
    }
}

