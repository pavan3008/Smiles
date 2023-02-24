//
//  NewTrip.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/8/23.
//

import SwiftUI

struct NewTrip: View {
    @Binding var trips: [String]
    @Binding var isPresented: Bool
    @State private var name = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Trip Name")) {
                    TextField("Enter name", text: $name)
                }
                Section {
                    Button("Save") {
                        saveTrip()
                    }
                }
            }
            .navigationBarTitle("New Trip")
            .navigationBarItems(
                trailing:
                    Button("Cancel") {
                        isPresented = false
                    }
            )
        }
    }
    
    func saveTrip() {
        trips.append(name)
        isPresented = false
    }
}

struct NewTrip_Previews: PreviewProvider {
    static var previews: some View {
        TripView().previewDevice("iPhone 14 Pro Max")
    }
}
