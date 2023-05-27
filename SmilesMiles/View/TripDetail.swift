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
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        TabView {
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
        .navigationBarTitle(trip.tripName)
        .navigationBarItems(trailing: Button(action: {
            tripViewModel.deleteTrip(tripId: trip.tripID)
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Delete")
        })
        .background(Color(UIColor.green))
        .onAppear {
            // do something on appearance
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
        TripView(viewModel: TripViewModel()).previewDevice("iPhone 14 Pro Max")
    }
}
