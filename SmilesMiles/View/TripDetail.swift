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
        .navigationBarItems(trailing: Button(action: deleteTrip) {
            Text("Delete")
        })
        .background(Color(UIColor.green))
    }

    func deleteTrip() {
        // Implement the code to delete the current trip here
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
