//
//  ContentView.swift
//  To-do
//
//  Created by Hoành Long on 18/10/2023.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        
        Group{
            if authViewModel.userSession != nil {
                TaskView()
            } else {
                LoginView()
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

