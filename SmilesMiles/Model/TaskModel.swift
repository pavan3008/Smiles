//
//  TaskModel.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 5/28/23.
//

import Foundation

struct Task: Codable, Equatable {
    let taskId: String
    var taskName: String   // Changed to var
    var taskStatus: String // Changed to var
    
    var isCompleted: Bool {
        return taskStatus == "complete"
    }
}
