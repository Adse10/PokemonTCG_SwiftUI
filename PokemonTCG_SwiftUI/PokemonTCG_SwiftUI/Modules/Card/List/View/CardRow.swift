//
//  CardRow.swift
//  PokemonTCG_SwiftUI
//
//  Created by Adrián Bolaños Ríos on 27/04/2021.
//

import SwiftUI
import FetchImage

struct CardRow: View {
    
    let card: Card
    @StateObject private var image = FetchImage()
    @State private var isActive = false
    @State var idCard: String = ""
    
    var body: some View {
        ZStack {
            if image.isLoading {
                Rectangle()
                    .fill(Color.gray)
            }else {
                image.view?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .onTapGesture {
                        self.isActive = true
                        self.idCard = card.id
                    }
                    .background(NavigationLink(destination: CardDetailView(idCard: self.idCard), isActive: $isActive, label: {
                        EmptyView()
                    }))
            }
        }
        .animation(.default)
        .onAppear(perform: {
            if let urlImage = card.images?.small {
                let url = URL(string: urlImage)
                image.load(url!)
            }
            
        })
        .onDisappear(perform: {
            image.cancel()
        })
    }
}
