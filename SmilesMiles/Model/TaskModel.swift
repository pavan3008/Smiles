//
//  TaskModel.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 5/28/23.
//

import Foundation

struct Task: Identifiable, Equatable {
    let id = UUID()
    let description: String
    var isCompleted: Bool
}
