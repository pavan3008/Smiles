//
//  TripView.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/8/23.
//

import SwiftUI

struct TripView: View {
    @State private var trips = [String]()
    @State private var searchText = ""
    @State private var isPresentingNewTrip = false
    @State private var selectedTrip: String?
    
    var body: some View{
        NavigationView {
            VStack {
                List {
                    ForEach(trips.filter { searchText.isEmpty || $0.localizedCaseInsensitiveContains(searchText) }, id: \.self) { trip in
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
                .sheet(isPresented: $isPresentingNewTrip) {
                    NewTrip(trips: $trips, isPresented: $isPresentingNewTrip)
                }
                Spacer()

                    Button(action: {
                        isPresentingNewTrip = true
                    }) {
                        HStack {
                            Circle()
                                .fill(Color(#colorLiteral(red: 0.20392157137393951, green: 0.7803921699523926, blue: 0.3490196168422699, alpha: 1)))
                                .frame(width: 57, height: 57)
                                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3700000047683716)), radius:24, x:4, y:4)
                                .overlay(
                                    Image(systemName: "plus")
                                        .foregroundColor(.white)
                                )
                        }
                        .padding(.bottom, 46)
                    }
                    .padding(.trailing, -214.0)
                    
                   
            }
        }
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



