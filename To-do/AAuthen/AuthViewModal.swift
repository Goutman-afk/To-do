//
//  AuthViewModal.swift
//  To-do
//
//  Created by Hoành Long on 21/10/2023.
//

import Foundation

import Firebase
import FirebaseFirestoreSwift
import FirebaseCore
import FirebaseFirestore

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: Firebase.User?
    @Published var currentUser: User?
 
    
    init(){
        self.userSession = Auth.auth().currentUser

    }
    
    
    func signIn( withEmail email: String, password: String) async throws {
        do {
              let result = try await Auth.auth().signIn(withEmail: email, password: password)
              self.userSession = result.user
              print(result.user.uid)
          } catch let error as NSError {
              print(error.localizedDescription)
              throw error
          }
      
        
    }
    
    
    func Logout()  {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print(error)
        }
      
        
    }
    
    func createUser( withEmail email: String, password: String, phone: String ) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User( id: result.user.uid, phone: phone, email: email )
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
            
            
            print(result.user.uid)
        } catch let error as NSError {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func fectUser( ) async throws  -> User? {
        return currentUser
    }
        
    
    func addToDoItem(_ toDoItem: ToDoItem) async throws {
        guard let userId = userSession?.uid else {
            throw NSError(domain: "User not logged in", code: 1)
        }

        do {
            let newToDoItemRef = Firestore.firestore().collection("users").document(userId).collection("toDoItems").document()
            let encodedToDoItem = try Firestore.Encoder().encode(toDoItem)
            try await newToDoItemRef.setData(encodedToDoItem)
        } catch {
            print("Failed to add to-do item: \(error)")
        }
    }
    
    func fetchToDoItems() async throws -> [ToDoItem] {
        guard let userId = userSession?.uid else {
            throw NSError(domain: "User not logged in", code: 1)
        }

        do {
            let querySnapshot = try await Firestore.firestore().collection("users").document(userId).collection("toDoItems").getDocuments()
            let toDoItems = querySnapshot.documents.compactMap { queryDocumentSnapshot -> ToDoItem? in
                return try? queryDocumentSnapshot.data(as: ToDoItem.self)
            }
            return toDoItems
        } catch {
            print("Failed to fetch to-do items: \(error)")
            throw error
        }
    }
}
