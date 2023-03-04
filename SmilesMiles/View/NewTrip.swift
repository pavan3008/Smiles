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
    @Binding var numberOfTrips: Int
    @StateObject var viewModel: NewTripViewModel

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Trip Name")) {
                    TextField("Enter name", text: $viewModel.name)
                }
                Section {
                    Button("Save") {
                        viewModel.saveTrip()
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

    init(trips: Binding<[String]>, isPresented: Binding<Bool>, numberOfTrips: Binding<Int>) {
        self._trips = trips
        self._isPresented = isPresented
        self._numberOfTrips = numberOfTrips
        self._viewModel = StateObject(wrappedValue: NewTripViewModel(trips: trips, isPresented: isPresented, numberOfTrips: numberOfTrips))
    }
}

struct NewTrip_Previews: PreviewProvider {
    static var previews: some View {
        TripView().previewDevice("iPhone 14 Pro Max")
    }
}
