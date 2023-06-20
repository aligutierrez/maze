//
//  PeopleDetailView.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct PeopleDetailView: View {
    let person: Person
    let screen = UIScreen.main.bounds
    
    @StateObject var viewModel = PeopleDetailViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    WebImage(url: person.image)
                        .placeholder(Image(systemName: "person.fill"))
                        .resizable()
                        .indicator(.activity)
                        .scaledToFill()
                        .frame(width:100,height: 100)
                    .clipShape(Circle())
                    Spacer()
                }
                .task {
                     getShowsForPerson()
                }
                
                Text(person.name)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.headline)
                
                if viewModel.shows.isEmpty {
                    Text("No shows to display")
                    Spacer()
                } else {
                    NavigationStack {
                        List(viewModel.shows) { show in
                            NavigationLink(destination: DetailView(show: show)) {
                                ShowRowView(show: show)
                            }
                        }
                        .padding(.top, 40)
                        .listStyle(PlainListStyle())
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
    
    func getShowsForPerson() {
        viewModel.getShowsFromPerson(with: person.id)
    }
}



