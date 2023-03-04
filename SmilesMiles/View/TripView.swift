//
//  TripView.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/8/23.
//

import SwiftUI

struct TripView: View {
    @ObservedObject private var viewModel = TripViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(viewModel.filteredTrips(), id: \.self) { trip in
                            NavigationLink(destination: TripDetail(tripName: trip, trips: $viewModel.trips, numberOfTrips: $viewModel.numberOfTrips)) {
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
                            viewModel.isPresentingNewTrip = true
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
            .sheet(isPresented: $viewModel.isPresentingNewTrip) {
                NewTrip(trips: $viewModel.trips, isPresented: $viewModel.isPresentingNewTrip, numberOfTrips: $viewModel.numberOfTrips)
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
