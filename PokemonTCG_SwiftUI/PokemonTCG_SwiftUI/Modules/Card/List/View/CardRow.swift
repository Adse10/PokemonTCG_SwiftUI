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
    
    var body: some View {
        ZStack {
            if image.isLoading {
                Rectangle()
                    .fill(Color.gray)
            }else {
                image.view?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
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
