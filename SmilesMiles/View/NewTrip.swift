//
//  NewTrip.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/8/23.
//

import SwiftUI

struct NewTrip: View {
    @ObservedObject var viewModel: NewTripViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Trip Details")) {
                    TextField("Trip Name", text: $viewModel.name)
                }
                Section(header: Text("Trip Status")) {
                    Text("In Progress")
                }
                Section {
                    Button(action: {
                        viewModel.saveTrip()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                    }
                    .disabled(viewModel.name.isEmpty)
                }
            }
            .navigationBarTitle("New Trip", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        viewModel.cancel()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
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
        TripView(viewModel: TripViewModel()).previewDevice("iPhone 14 Pro Max")
    }
}
