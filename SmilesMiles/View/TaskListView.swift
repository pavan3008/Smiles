//
//  TaskListView.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/15/23.
//

import SwiftUI

struct TaskListView: View {
    @State private var tasks: [Task] = []
    @State private var newTask = ""

    var body: some View {
        VStack {
            HStack {
                TextField("New Task", text: $newTask)
                Button(action: addTask) {
                    Text("Add")
                }
            }
            .padding()

            List {
                ForEach(tasks.sorted(by: { !$0.isCompleted && $1.isCompleted })) { task in
                    HStack {
                        Button(action: {
                            if let index = tasks.firstIndex(of: task) {
                                tasks[index].isCompleted.toggle()
                                tasks.sort(by: { !$0.isCompleted && $1.isCompleted })
                            }
                        }) {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(.green)
                        }
                        Text(task.description)
                    }
                }
                .onDelete(perform: deleteTask)
            }
        }
    }

    func addTask() {
        guard !newTask.isEmpty else { return }
        tasks.append(Task(description: newTask, isCompleted: false))
        tasks.sort(by: { !$0.isCompleted && $1.isCompleted })
        newTask = ""
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

struct Task: Identifiable, Equatable {
    let id = UUID()
    let description: String
    var isCompleted: Bool
}
