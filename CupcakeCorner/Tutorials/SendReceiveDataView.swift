//
//  SendReceiveDataView.swift
//  CupcakeCorner
//
//  Created by Sean Dooley on 26/11/2024.
//

import SwiftUI

struct SendReceiveDataView: View {
    @State private var results = [Result]()

    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }
    
    struct Response: Codable {
        var results: [Result]
    }

    struct Result: Codable {
        var trackId: Int
        var trackName: String
        var collectionName: String
    }
    
    func loadData() async {
        // Creating the URL we want to read
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        // Fetching the data for that URL
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            // Decoding the result of that data
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    results = decodedResponse.results
                }
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    SendReceiveDataView()
}
