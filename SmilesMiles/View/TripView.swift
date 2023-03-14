//
//  TripView.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/8/23.
//

import SwiftUI

struct TripView: View {
    @ObservedObject private var viewModel = TripViewModel()
    @State private var isPresentingNewTrip = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(viewModel.filteredTrips(), id: \.self) { trip in
                            NavigationLink(destination: TripDetail(tripName: trip, numberOfTrips: $viewModel.numberOfTrips, tripViewModel: viewModel)) {
                                Text(trip)
                            }
                        }
                        .onDelete(perform: viewModel.deleteTrip)
                    }
                    .navigationBarTitle("Trips")
                    .navigationBarItems(
                        trailing:
                            Button(action: {
                                // handle profile icon tap
                            }) {
                            Image(systemName: "person.circle")
                        }
                    )
                    .searchable(text: $viewModel.searchText)
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            isPresentingNewTrip = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .foregroundColor(.green)
                                .frame(width: 70, height: 70)
                                .shadow(radius: 3)
                        }
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .padding(.trailing, 75)
                        .padding(.bottom, 40)
                    }
                }
            }
            .sheet(isPresented: $isPresentingNewTrip) {
                NewTrip(viewModel: NewTripViewModel(trips: viewModel.trips, onSave: { tripName in
                    viewModel.addTrip(tripName)
                    isPresentingNewTrip = false
                }, onCancel: {
                    isPresentingNewTrip = false
                }))
            }
        }
        .accentColor(.green)
    }
}

struct TripView_Previews: PreviewProvider {
    static var previews: some View {
        TripView().previewDevice("iPhone 14 Pro Max")
    }
}
