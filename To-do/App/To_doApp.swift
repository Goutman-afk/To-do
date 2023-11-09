

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
@main
struct To_doApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewModel)
        }
    }
}
