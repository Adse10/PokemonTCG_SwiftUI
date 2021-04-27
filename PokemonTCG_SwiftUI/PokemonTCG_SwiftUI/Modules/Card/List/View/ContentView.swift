//
//  ContentView.swift
//  PokemonTCG_SwiftUI
//
//  Created by Adrián Bolaños Ríos on 27/04/2021.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @StateObject var dataSource = CardListViewModel()
    
    var layout: [GridItem]{
        [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
    }
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView{
                    LazyVGrid(columns: layout, alignment: .center){
                        ForEach(dataSource.listCard){ card in
                            CardRow(card: card)
                                .onAppear {
                                    dataSource.loadMoreContent(card: card)
                                }
                        }
                    }.animation(.default)
                    
                }
            }
            .navigationTitle("cards".localize())
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
