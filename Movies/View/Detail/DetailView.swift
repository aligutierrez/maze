//
//  DetailView.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    @StateObject var viewModel = DetailViewModel()
    @State private var isExpanded: Bool = false
    @State private var schedule = ""
    @State private var genre = ""
    @State private var summary = ""
    @State private var selectedSeason: Int = 1
    
    let show: Show
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    VStack {
                        DetailHeaderView(show: show, genre: genre)
                        HStack {
                            Text(schedule)
                                .padding(.horizontal, 16)
                            Spacer()
                        }
                        
                        Text(summary)
                            .lineLimit(isExpanded ? nil : 3)
                            .overlay(
                                GeometryReader { proxy in
                                    Button(action: {
                                        isExpanded.toggle()
                                    }) {
                                        Text(isExpanded ? "See less" : "See more")
                                            .font(.caption).bold()
                                            .padding(.leading, 8.0)
                                            .padding(.top, 4.0)
                                            .background(Color.white)
                                    }
                                    .frame(width: proxy.size.width, height: proxy.size.height, alignment: .bottomTrailing)
                                }
                            )
                            .padding(.all, 16)
                        
                        Picker(selection: $selectedSeason, label: Text("Season")) {
                            if viewModel.seasonsCount > 0 {
                                ForEach(1...viewModel.seasonsCount, id: \.self) { i in
                                    Text("Season \(i)")
                                }
                            }
                        }
                        .onChange(of: selectedSeason) { season in
                            getSeasonEpisodes()
                        }
                        
                    }
                    
                    List(viewModel.filteredEpisodes) { episode in
                        NavigationLink(destination: EpisodeView(episode: episode)) {
                            HStack {
                                WebImage(url: episode.image)
                                    .resizable()
                                    .indicator(.activity)
                                    .scaledToFill()
                                    .frame(width: 75, height: 75)
                                    .clipped()
                                VStack {
                                    Text(episode.name)
                                        .frame(maxWidth: .infinity, alignment: .topLeading)
                                        .font(.headline)
                                    Text(episode.summary ?? "")
                                        .frame(maxWidth: .infinity, alignment: .topLeading)
                                        .font(.subheadline)
                                        .lineLimit(3)
                                    Spacer()
                                }
                            }
                            Spacer()
                        }
                    }
                }
                .onAppear {
                    setUpInitialState()
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
    
    func setUpInitialState() {
        let time = show.schedule.time
        let days = show.schedule.days.joined(separator: ", ")
        let genres = show.genres
        
        if time.isEmpty, days.isEmpty {
            schedule = "No schedule available.".localized
        } else if !time.isEmpty, days.isEmpty {
            schedule = "At %@.".localizedWith(time)
        } else if time.isEmpty, !days.isEmpty {
            schedule = "On %d.".localizedWith(days)
        } else {
            schedule = "At %1$@ on %2$@.".localizedWith(time, days)
        }
        
        
        if !genres.isEmpty {
            genre = genres.joined(separator: ", ")
        } else {
            genre = "No genres available.".localized
        }
        
        if let summary = show.summary, !summary.isEmpty{
            self.summary = summary
        } else {
            self.summary = "No summary available.".localized
        }
        
        viewModel.getEpisodes(for: show.id)
    }
    
    func getSeasonEpisodes() {
        viewModel.getEpisodesBySeason(for: selectedSeason)
    }
}
