//
//  CardDetailView.swift
//  PokemonTCG_SwiftUI
//
//  Created by Adrián Bolaños Ríos on 27/04/2021.
//

import SwiftUI
import Combine

struct CardDetailView: View {
    
    private var idCard: String?
    @StateObject var dataSource = CardDetailViewModel()
    
    init(idCard: String){
        self.idCard = idCard
    }
    
    var body: some View {
        
        VStack {
            ScrollView{
                Text("nombre: \(dataSource.card.name ?? "")")
                Text("Número: \(dataSource.card.number ?? "")")
            }
        }.onAppear {
            dataSource.loadData(idCard!)
        }
        
    }
}

/*struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView()
    }
} */
