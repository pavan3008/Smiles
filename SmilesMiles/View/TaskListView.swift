//
//  TaskListView.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/15/23.
//

import SwiftUI

struct TaskListView: View {
    let tripId: String
    @ObservedObject var tripViewModel: TripViewModel
    @StateObject private var viewModel: TaskListViewModel
    
    init(tripId: String, tripViewModel: TripViewModel) {
        self.tripId = tripId
        self.tripViewModel = tripViewModel
        self._viewModel = StateObject(wrappedValue: TaskListViewModel(trips: tripViewModel))
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("New Task", text: $viewModel.newTask)
                Button(action: {
                    viewModel.addTask(tripId: tripId)
                }) {
                    Text("Add")
                }
            }
            .padding()
            List {
                ForEach(viewModel.filteredTasks, id: \.taskId) { task in
                    HStack {
                        Button(action: {
                            viewModel.updateTaskStatus(taskId: task.taskId)
                        }) {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(.green)
                        }
                        TextField("Task Name", text: Binding(
                            get: { task.taskName },
                            set: { viewModel.updateTaskName(taskId: task.taskId, newTaskName: $0) }
                        ))
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let task = viewModel.filteredTasks[index]
                        viewModel.deleteTask(taskId: task.taskId) { result in
                            switch result {
                            case .success:
                                print("Task deleted successfully")
                            case .failure(let error):
                                print("Error deleting task: \(error)")
                            }
                        }
                    }
                }
                
            }
            
        }
        .onAppear {
            viewModel.getTasksForTrip(tripId: tripId) { result in
                switch result {
                case .success(let tasks):
                    viewModel.tasks = tasks.sorted(by: { $0.taskStatus != "complete" && $1.taskStatus != "incomplete" })
                case .failure(let error):
                    print("Error fetching tasks: \(error)")
                }
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TripView(viewModel: TripViewModel()).previewDevice("iPhone 14 Pro Max")
    }
}
