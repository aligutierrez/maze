//
//  PeopleSearchView.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import SwiftUI

struct PeopleSearchView: View {
    @StateObject var viewModel = PeopleViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.people) { person in
                NavigationLink(destination: PeopleDetailView(person: person)) {
                    PeopleRowView(person: person)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("People!")
            .searchable(text: $viewModel.searchText)
            .onSubmit(of: .search, getPeopleFromSearch)
            .onChange(of: viewModel.searchText) { _ in
                if viewModel.searchText.isEmpty {
                    viewModel.people.removeAll()
                }
            }
        }
        
        if viewModel.isLoadingPage {
            ProgressView()
        }
        
    }
    
    func getPeopleFromSearch() {
        viewModel.getPeople(with: viewModel.searchText)
    }
}

