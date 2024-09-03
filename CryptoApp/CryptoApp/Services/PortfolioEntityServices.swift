//
//  PortfolioEntityServices.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 22/08/24.
//

import Foundation
import CoreData

class PortfolioEntityServices {
    private let container : NSPersistentContainer
    private let containerName = "PortfolioModel"
    private let entityName = "PortfolioEntity"
    
    @Published var savedEntities : [PortfolioEntity] = []
    
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error {
                print("Error loading Core Data")
            }
            
            self.getPortfolio()
        }
        
    }
    // MARK: Public
    
    func updatePortfolio(coin:CoinModel, amount:Double) {
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                updateCoin(entity: entity, amount: amount)
            }
            else {
                delete(entity: entity)
            }
                 
        }
        else {
            add(coin: coin, amount: amount)
        }
        
    }
    
    // MARK : Private
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities =  try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching portfolio entities: \(error)")
        }
    }
      
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to CoreData: \(error)")
        }
    }
    
    private func updateCoin(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
    
    
}
