//
//  TripView.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/8/23.
//

import SwiftUI

struct TripView: View {
    @State private var trips = ["New York"] //  [String]()
    @State private var searchText = ""
    @State private var isPresentingNewTrip = false
    @State private var selectedTrip: String?
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        let filteredTrips = trips.filter { searchText.isEmpty || $0.localizedCaseInsensitiveContains(searchText) }
                        ForEach(filteredTrips, id: \.self) { trip in
                            NavigationLink(destination: TripDetail(tripName: trip)) {
                                Text(trip)
                            }
                        }
                        .onDelete(perform: deleteTrip)
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
                    .searchable(text: $searchText)
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
                NewTrip(trips: $trips, isPresented: $isPresentingNewTrip)
            }
        }
        .accentColor(.green)
    }
    func deleteTrip(at offsets: IndexSet) {
        trips.remove(atOffsets: offsets)
    }
}

struct TripView_Previews: PreviewProvider {
    static var previews: some View {
        TripView().previewDevice("iPhone 14 Pro Max")
    }
}
