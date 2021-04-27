//
//  CardManagerConnection.swift
//  PokemonTCG_SwiftUI
//
//  Created by Adrián Bolaños Ríos on 27/04/2021.
//

import Foundation
import Combine

class CardManagerConnection {
    
    /* Función para obtener el listado de cartas */
    func getListCard(page: Int) -> AnyPublisher<[Card], Error> {
        
        let session = URLSession.shared
        
        var components = URLComponents(string: Endpoints.main + Endpoints.listCard)
        components?.queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "pageSize", value: "20")
        ]
        
        let request = URLRequest(url: (components?.url)!)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return session.dataTaskPublisher(for: request)
            .map{$0.data}
            .decode(type: Cards.self, decoder: decoder)
            .map{ $0.cards}
            .eraseToAnyPublisher()
        
        
    }
    
    /* Función para obtener el detalle de una carta */
    func getDetailCard(idCard: String) -> AnyPublisher<Card, Error> {
        
        let session = URLSession.shared
        
        var components = URLComponents(string: Endpoints.main + Endpoints.detailCard + idCard)
        
        let request = URLRequest(url: (components?.url)!)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return session.dataTaskPublisher(for: request)
            .map{$0.data}
            .decode(type: CardDetail.self, decoder: decoder)
            .map{ $0.card}
            .eraseToAnyPublisher()
        
        
    }
}
