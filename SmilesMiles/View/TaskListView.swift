//
//  TaskListView.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/15/23.
//

import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskListViewModel()
    
    var body: some View {
        VStack {
            HStack {
                TextField("New Task", text: $viewModel.newTask)
                Button(action: viewModel.addTask) {
                    Text("Add")
                }
            }
            .padding()
            List {
                ForEach(viewModel.filteredTasks) { task in
                    HStack {
                        Button(action: {
                            viewModel.toggleCompleted(for: task)
                        }) {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(.green)
                        }
                        Text(task.description)
                    }
                }
                .onDelete(perform: viewModel.deleteTask)
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TripView().previewDevice("iPhone 14 Pro Max")
    }
}
