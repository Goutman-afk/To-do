//
//  User.swift
//  To-do
//
//  Created by Hoành Long on 21/10/2023.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let phone: String
    let email: String
    
}
struct ToDoItem: Identifiable,Codable {
    var id = UUID()
    var title: String
    var isDone: Bool
}
