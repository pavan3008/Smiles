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
        VStack {
            TabView(selection: $selectedTab) {
                TaskList()
                    .tag(0)
                BudgetView()
                    .tag(1)
                MembersView()
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .padding(.top)
            
            Spacer()
        }
        .navigationBarTitle(tripName)
    }
}

struct TaskList: View {
    var body: some View {
        Text("Tasks")
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
