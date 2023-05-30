//
//  TaskListViewModel.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/27/23.
//

import SwiftUI
import Alamofire

class TaskListViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var searchText = ""
    @Published var newTask = ""
    let trips: TripViewModel
    
    private var originalTasks: [Task] = []
    
    init(tasks: [Task] = [], trips: TripViewModel) {
        self.tasks = tasks
        self.originalTasks = tasks
        self.trips = trips
    }
    
    var filteredTasks: [Task] {
        if searchText.isEmpty {
            return tasks
        } else {
            return tasks.filter { $0.taskName.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func addTask(tripId: String) {
        guard !newTask.isEmpty else { return }
        
        createTask(tripId: tripId, taskName: self.newTask) { result in
            switch result {
            case .success(let createdTask):
                self.tasks.insert(createdTask, at: 0)
            case .failure(let error):
                print("Error creating task: \(error)")
            }
        }
        
        self.newTask = ""
    }
    
    func createTask(tripId: String, taskName: String, completion: @escaping (Result<Task, Error>) -> Void) {
        let url = "https://c0clbl0v9h.execute-api.us-west-2.amazonaws.com/prod/trips/\(tripId)/tasks"
        let parameters: [String: Any] = [
            "task_name": taskName
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: Task.self) { response in
                switch response.result {
                case .success(let taskResponse):
                    completion(.success(taskResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getTasksForTrip(tripId: String, completion: @escaping (Result<[Task], Error>) -> Void) {
        let urlString = "https://c0clbl0v9h.execute-api.us-west-2.amazonaws.com/prod/trips/\(tripId)/tasks"
        
        AF.request(urlString)
            .validate()
            .responseDecodable(of: [Task].self) { response in
                switch response.result {
                case .success(let tasks):
                    completion(.success(tasks))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func updateTaskName(taskId: String, newTaskName: String) {
        if let index = tasks.firstIndex(where: { $0.taskId == taskId }), tasks[index].taskName != newTaskName {
            tasks[index].taskName = newTaskName
            updateTask(taskId: taskId, taskName: newTaskName) { result in
                switch result {
                case .success(let updatedTask):
                    print("Task name updated successfully: \(updatedTask)")
                case .failure(let error):
                    print("Error updating task name: \(error)")
                }
            }
        }
    }
    
    func updateTaskStatus(taskId: String) {
        if let index = tasks.firstIndex(where: { $0.taskId == taskId }) {
            let newTaskStatus = tasks[index].isCompleted ? "incomplete" : "complete"
            tasks[index].taskStatus = newTaskStatus
            updateTask(taskId: taskId, taskStatus: newTaskStatus) { result in
                switch result {
                case .success(let updatedTask):
                    print("Task status updated successfully: \(updatedTask)")
                    self.tasks.sort(by: { $0.taskStatus == "incomplete" && $1.taskStatus == "complete" })
                case .failure(let error):
                    print("Error updating task status: \(error)")
                }
            }
        }
    }
    
    func updateTask(taskId: String, taskName: String? = nil, taskStatus: String? = nil, completion: @escaping (Result<Task, Error>) -> Void) {
        let url = "https://c0clbl0v9h.execute-api.us-west-2.amazonaws.com/prod/tasks/\(taskId)"
        
        var parameters: [String: Any] = [:]
        
        if let name = taskName {
            parameters["task_name"] = name
        }
        
        if let status = taskStatus {
            parameters["task_status"] = status
        }
        
        AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default).validate().responseDecodable(of: Task.self) { response in
            switch response.result {
            case .success(let updatedTask):
                completion(.success(updatedTask))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteTask(taskId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = "https://c0clbl0v9h.execute-api.us-west-2.amazonaws.com/prod/tasks/\(taskId)"
        
        AF.request(url, method: .delete)
            .validate()
            .response { [weak self] response in
                switch response.result {
                case .success:
                    self?.tasks.removeAll { $0.taskId == taskId }
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
