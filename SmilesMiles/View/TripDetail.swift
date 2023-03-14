//
//  TripDetail.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/13/23.
//

import SwiftUI

struct TripDetail: View {
    let tripName: String
    @State private var selectedTab = 0
    @Binding var numberOfTrips: Int
    @ObservedObject var tripViewModel: TripViewModel

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                TaskListView()
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Tasks")
            }
            NavigationView {
                BudgetView()
            }
            .tabItem {
                Image(systemName: "dollarsign.square.fill")
                Text("Budget")
            }
            NavigationView {
                MembersView()
            }
            .tabItem {
                Image(systemName: "person.3.fill")
                Text("Members")
            }
        }
        .accentColor(.green)
        .navigationBarTitle(tripName)
        .navigationBarItems(trailing: Button(action: {
            let viewModel = TripDetailViewModel(trips: tripViewModel.trips, numberOfTrips: tripViewModel.numberOfTrips, tripName: tripName)
            viewModel.deleteTrip()
        }) {
            Text("Delete")
        })
        .background(Color(UIColor.green))
        .onAppear {
            let viewModel = TripDetailViewModel(trips: tripViewModel.trips, numberOfTrips: tripViewModel.numberOfTrips, tripName: tripName)
            // do something with viewModel
        }
    }
}

struct BudgetView: View {
    var body: some View {
        Text("Budget")
    }
}

struct MembersView: View {
    var body: some View {
        Text("Members")
    }
}

struct TripDetail_Previews: PreviewProvider {
    static var previews: some View {
        TripView().previewDevice("iPhone 14 Pro Max")
    }
}
