//
//  TripDetail.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/13/23.
//

import SwiftUI

struct TripDetail: View {
    let trip: Trip
    @ObservedObject var tripViewModel: TripViewModel
    @State private var showingSettings = false

    var body: some View {
        TabView {
            NavigationView {
                TaskListView(tripId: trip.tripId, tripViewModel: tripViewModel)
                    .navigationBarTitle("Tasks")
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Tasks")
            }
            .tag(0)

            NavigationView {
                VStack {
                    BudgetView()
                }
                .navigationBarTitle("Budget")
            }
            .tabItem {
                Image(systemName: "dollarsign.square.fill")
                Text("Budget")
            }
            .tag(1)

            NavigationView {
                VStack {
                    MembersView(tripId: trip.tripId, tripViewModel: tripViewModel)
                }
                .navigationBarTitle("Members")
            }
            .tabItem {
                Image(systemName: "person.3.fill")
                Text("Members")
            }
            .tag(2)
        }
        .accentColor(.green)
        .navigationBarTitle(trip.tripName)
        .navigationBarItems(trailing: Button(action: {
            showingSettings = true
        }) {
            Image(systemName: "gearshape")
        })
        .sheet(isPresented: $showingSettings) {
            TripSettings(trip: trip, tripViewModel: tripViewModel)
        }
        .background(Color(UIColor.green))
        .onAppear {
            // do something on appearance
        }
    }
}

struct TripSettings: View {
    let trip: Trip
    @ObservedObject var tripViewModel: TripViewModel
    @Environment(\.presentationMode) var presentationMode

    @State private var modifiedTripName: String
    @State private var modifiedTripStatus: String

    init(trip: Trip, tripViewModel: TripViewModel) {
        self.trip = trip
        self.tripViewModel = tripViewModel
        _modifiedTripName = State(initialValue: trip.tripName)
        _modifiedTripStatus = State(initialValue: trip.status)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Trip Details")) {
                    TextField("Trip Name", text: $modifiedTripName)
                }
                Section(header: Text("Trip Status")) {
                    HStack {
                        Button(action: {
                            modifiedTripStatus = "Completed"
                        }) {
                            Text("Completed")
                                .foregroundColor(modifiedTripStatus == "Completed" ? .green : .primary)
                        }
                        .buttonStyle(PlainButtonStyle())

                        Spacer()

                        Button(action: {
                            modifiedTripStatus = "In Progress"
                        }) {
                            Text("In Progress")
                                .foregroundColor(modifiedTripStatus == "In Progress" ? .green : .primary)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                Section {
                    Button(action: {
                        tripViewModel.modifyTrip(tripId: trip.tripId, tripName: modifiedTripName, tripStatus: modifiedTripStatus) { result in
                            switch result {
                            case .success(let result):
                                // Handle success, update UI or perform any necessary actions
                                print("Trip modified successfully: \(String(describing: result))")

                            case .failure(let error):
                                // Handle error, display an error message or perform any necessary actions
                                print("Error modifying trip: \(error)")
                            }
                        }
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background((modifiedTripName != trip.tripName || modifiedTripStatus != trip.status) ? Color.green : Color.gray)
                            .cornerRadius(10)
                    }
                    .disabled(modifiedTripName.isEmpty)
                }
            }
            .navigationBarTitle("Edit Trip", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                }
            )
        }
        .accentColor(.green)
    }
}

struct BudgetView: View {
    var body: some View {
        Text("Budget")
    }
}

struct MembersView: View {
    let tripId: String
    @ObservedObject var tripViewModel: TripViewModel

    var body: some View {
        List(tripViewModel.users, id: \.userId) { user in
            Text(user.userData.username)
        }
        .onAppear {
            tripViewModel.getUsersForTrip(tripId: tripId)
        }
    }
}

struct TripDetail_Previews: PreviewProvider {
    static var previews: some View {
        TripView(viewModel: TripViewModel()).previewDevice("iPhone 14 Pro Max")
    }
}
