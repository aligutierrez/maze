//
//  EpisodeView.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/20/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct EpisodeView: View {
    let episode: Episode
    let screen = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                    }
                    .padding(.horizontal, 22)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            WebImage(url: episode.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: screen.width)
                            
                            HStack(spacing: 20) {
                                Text("\(episode.name) - S\(episode.season)E\(episode.number)")
                            }
                            .foregroundColor(.gray)
                            .padding(.vertical, 6)
                            
                            
                            Group {
                                HStack {
                                    Text("Initial airdate: \(episode.airdate)")
                                    
                                    Spacer()
                                }
                                .padding(.vertical, 4)
                                .padding(.horizontal, 16)
                                
                                HStack {
                                    Text(episode.summary ?? "")
                                        .font(.subheadline)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                }
            }
        }
    }
}
