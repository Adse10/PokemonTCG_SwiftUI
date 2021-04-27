//
//  CardListViewModel.swift
//  PokemonTCG_SwiftUI
//
//  Created by Adrián Bolaños Ríos on 27/04/2021.
//

import Foundation
import SwiftUI
import Combine

class CardListViewModel: ObservableObject {
    
    @Published var listCard = [Card]()
    @Published private var isLoadingPage = false
    
    private var connectionManager = CardManagerConnection()
    private var subscriptions: Set<AnyCancellable> = []
    private var page = 1
    private var otherPage = true
    
    init(){
        loadContent()
    }
    
    // MARK: - Funciones privadas
    
    private func loadContent(){
        
        guard !isLoadingPage && otherPage else {
            return
        }
        
        isLoadingPage = true
        
        connectionManager.getListCard(page: page)
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .handleEvents( receiveOutput: { response in
                self.isLoadingPage = false
                self.page += 1
                // Comprobamos si tenemos más paginas
                if response.count < 20 {
                    self.otherPage = false
                }
            })
            .map({ response in
                return self.listCard + response
            })
            .assign(to: \.listCard, on: self)
            .store(in: &subscriptions)
    }
    
    func loadMoreContent(card: Card?){
        guard let cardContent = card else {
            loadContent()
            return
        }
        
        let thresholdIndex = listCard.index(listCard.endIndex, offsetBy: -5)
        if listCard.firstIndex(where: { $0.id == cardContent.id }) == thresholdIndex {
            loadContent()
        }
    }
}
