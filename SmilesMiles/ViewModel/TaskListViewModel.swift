//
//  TaskListViewModel.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/27/23.
//

import SwiftUI

class TaskListViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var searchText = ""
    @Published var newTask = ""

    private var originalTasks: [Task] = []

    init(tasks: [Task] = []) {
        self.tasks = tasks
        self.originalTasks = tasks
    }

    var filteredTasks: [Task] {
        if searchText.isEmpty {
            return tasks
        } else {
            return tasks.filter { $0.description.localizedCaseInsensitiveContains(searchText) }
        }
    }

    func addTask() {
        guard !newTask.isEmpty else { return }
        let newTask = Task(description: self.newTask, isCompleted: false)
        if let firstUncompletedTaskIndex = tasks.firstIndex(where: { !$0.isCompleted }) {
            tasks.insert(newTask, at: firstUncompletedTaskIndex)
        } else {
            tasks.append(newTask)
        }
        self.newTask = ""
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    func toggleCompleted(for task: Task) {
        if let index = tasks.firstIndex(of: task) {
            tasks[index].isCompleted.toggle()
            tasks.sort(by: { !$0.isCompleted && $1.isCompleted })
        }
    }
}

struct Task: Identifiable, Equatable {
    let id = UUID()
    let description: String
    var isCompleted: Bool
}
