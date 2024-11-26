//
//  CodableConformanceClassView.swift
//  CupcakeCorner
//
//  Created by Sean Dooley on 26/11/2024.
//

import SwiftUI

struct CodableConformanceClassView: View {
    var body: some View {
        Button("Encode Taylor", action: encodeTaylor)
    }

    func encodeTaylor() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
    
    @Observable
    class User: Codable {
        enum CodingKeys: String, CodingKey {
            case _name = "name"
        }

        var name = "Taylor"
    }
}

#Preview {
    CodableConformanceClassView()
}
