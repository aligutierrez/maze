//
//  PeopleRowView.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/20/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct PeopleRowView: View {
    let person: Person
    var body: some View {
        HStack {
            WebImage(url: person.image)
                .placeholder(Image(systemName: "person.fill"))
                .resizable()
                .indicator(.activity)
                .scaledToFill()
                .frame(width: 75, height: 75)
                .clipped()
            VStack {
                Text(person.name)
                Spacer()
            }

        }
    }
}

