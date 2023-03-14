//
//  NewTrip.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/8/23.
//

import SwiftUI

struct NewTrip: View {
    @ObservedObject var viewModel: NewTripViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Trip Details")) {
                    TextField("Trip Name", text: $viewModel.name)
                }
                Section {
                    Button("Save") {
                        viewModel.saveTrip()
                    }
                    .disabled(viewModel.name.isEmpty)
                }
            }
            .navigationBarTitle("New Trip", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button("Cancel") {
                        viewModel.cancel()
                    }
            )
            .alert(isPresented: $viewModel.isDuplicateTripName) {
                Alert(
                    title: Text("Duplicate Trip Name"),
                    message: Text("A trip with this name already exists."),
                    dismissButton: .default(
                        Text("OK")
                            .foregroundColor(.green)
                    )
                )
            }
        }
        .accentColor(.green)
    }
}

struct NewTrip_Previews: PreviewProvider {
    static var previews: some View {
        TripView().previewDevice("iPhone 14 Pro Max")
    }
}
