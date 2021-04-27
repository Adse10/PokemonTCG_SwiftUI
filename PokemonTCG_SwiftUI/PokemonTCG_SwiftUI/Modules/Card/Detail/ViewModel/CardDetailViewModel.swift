//
//  CardDetailViewModel.swift
//  PokemonTCG_SwiftUI
//
//  Created by Adrián Bolaños Ríos on 27/04/2021.
//

import Foundation
import SwiftUI
import Combine

class CardDetailViewModel: ObservableObject {
    
    @Published var card = Card()
    
    
    private var connectionManager = CardManagerConnection()
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Funciones privadas
    func loadData(_ idCard: String){
        
        connectionManager.getDetailCard(idCard: idCard)
            .replaceError(with: Card())
            .receive(on: DispatchQueue.main)
            .assign(to: \.card, on: self)
            .store(in: &subscriptions)
    }
}
