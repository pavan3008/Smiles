//
//  TripView.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/8/23.
//

import SwiftUI
import Alamofire

struct TripView: View {
    @ObservedObject var viewModel: TripViewModel
    @State private var isPresentingNewTrip = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(viewModel.filteredTrips(), id: \.tripID) { trip in
                            NavigationLink(destination: TripDetail(trip: trip, tripViewModel: viewModel)) {
                                VStack(alignment: .leading) {
                                    Text(trip.tripName)
                                        .font(.headline)
                                    getProgressBarColor(for: trip.status)
                                        .frame(height: 8)
                                        .cornerRadius(4.0)
                                }
                            }
                        }
                        .onDelete { indexSet in
                            if let index = indexSet.first {
                                let trip = viewModel.filteredTrips()[index]
                                viewModel.deleteTrip(tripId: trip.tripID)
                            }
                        }
                    }
                    .navigationBarTitle("Trips")
                    .navigationBarItems(
                        trailing:
                            Button(action: {
                                viewModel.getUserDetails()
                            }) {
                                Image(systemName: "person.circle")
                            }
                    )
                    .searchable(text: $viewModel.searchText)
                }
                
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            NavigationLink(destination: NewTrip(viewModel: NewTripViewModel(trips: viewModel, onSave: { message in
                                print(message)
                            }, onCancel: {
                                // Handle cancel action if needed
                            }))) {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .foregroundColor(.green)
                                    .frame(width: 70, height: 70)
                                    .shadow(radius: 3)
                            }
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                            .padding(.trailing, geometry.size.width * 0.16) // Adjust the padding based on the screen width
                            .padding(.bottom, geometry.size.height * 0.08) // Adjust the padding based on the screen height
                        }
                    }
                }
            }
        }
        .accentColor(.green)
        .onAppear {
            viewModel.getUserDetails()
            viewModel.fetchTrips(for: viewModel.user?.sub ?? "")
        }
        .onChange(of: viewModel.user?.sub) { userId in
            if let userId = userId {
                viewModel.fetchTrips(for: userId)
            }
        }
    }
    
    @ViewBuilder
    private func getProgressBarColor(for status: String) -> some View {
        if status == "Completed" {
            Rectangle()
                .foregroundColor(.green)
        } else {
            Rectangle()
                .foregroundColor(.yellow)
        }
    }
}

struct TripView_Previews: PreviewProvider {
    static var previews: some View {
        TripView(viewModel: TripViewModel()).previewDevice("iPhone 14 Pro Max")
    }
}
