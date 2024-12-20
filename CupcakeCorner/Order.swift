//
//  Order.swift
//  CupcakeCorner
//
//  Created by Sean Dooley on 26/11/2024.
//

import SwiftUI

@Observable
class Order: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isBlank || streetAddress.isBlank || city.isBlank || zip.isBlank {
            return false
        }
        
        return true
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2

        // complicated cakes cost more
        cost += Decimal(type) / 2

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }

        return cost
    }
    
    init() {
        load()
    }

    func save() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: "order")
        }
    }

    func load() {
        if let savedOrder = UserDefaults.standard.data(forKey: "order") {
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: savedOrder) {
                
                self.name = decodedOrder.name
                self.streetAddress = decodedOrder.streetAddress
                self.city = decodedOrder.city
                self.zip = decodedOrder.zip
            }
        }
    }
}
