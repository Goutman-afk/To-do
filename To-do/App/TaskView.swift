//
//  TaskView.swift
//  To-do
//
//  Created by Hoành Long on 01/11/2023.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var toDoItems: [ToDoItem] = []
    @State private var isAddingItem = false
   
    var body: some View {
        VStack {
            ZStack {
                Rectangle().frame(width: .infinity).foregroundColor(Color("task").opacity(0.67))
                    .ignoresSafeArea()
                VStack{
                    Spacer()
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 3)
                            .fill(Color("Color 2"))
                            .frame(width: 90, height: 90)
                    
                        Image("istockphoto-1325013514-612x612")
                                           .resizable()
                                           .scaledToFill()
                                           .frame(width: 80, height: 80)
                                           .clipShape(Circle())
                    } .padding(.top, 60)
                        
                    
                    Text("Huynh Long")
                        .font(Font.custom("Poppins-Medium", size: 14))
                        .padding(.top, 6)
                    
                    Text("@huynhlong")
                        .foregroundStyle(Color("Color 2"))
                        .font(Font.custom("Poppins-Medium", size: 10))
                    Button(action: {
                        
                        authViewModel.Logout()
                        
                    }){
                        ZStack {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color("n"))
                                .frame(width: 89, height: 22)
                            Text("Logout")
                                .font(Font.custom("Poppins-Medium", size: 10))
                                .foregroundColor(Color.black)
                                
                        }
                        .padding(.top, 10)
                        
                    }
                    Spacer()
                    
                }
                
            }.frame(height: UIScreen.main.bounds.height * 0.32)
                .padding(.top,100)
            
            Spacer()
            
            ZStack {
                
                Rectangle().frame(width: .infinity).foregroundColor(.white)
                
                VStack{
                   ClockView()
                        .padding(.top, 30)
                    Text("Good Afternoon")
                        .font(Font.custom("Poppins-SemiBold",size: 12))
                        .padding(.top, 10)
                   
                    Text("Task List")
                        .font(Font.custom("Poppins-SemiBold",size: 20))
                        .foregroundColor(Color.black)
                        .padding(.leading, -170)
                        .padding(.top, 20)
                
                    ScrollView() {
                        HStack{
                            Text("Task List")
                                .font(Font.custom("Poppins-Regular",size: 17))
                                .foregroundColor(.black.opacity(0.8))
                                .bold()
                               
                                .foregroundColor(Color.black)
                            Spacer()
                            Button(action: {
                                
                                isAddingItem = true
                                print("add")
                                 
                            }){
                               Image(systemName: "plus.circle")
                                    .font(.title)
                                    .foregroundColor(Color("task"))
                                    
                            }.sheet(isPresented: $isAddingItem) {
                                AddNewItemView(isAddingItem: $isAddingItem, toDoItems: $toDoItems)
                            }
                        } .padding()
                        
                                    LazyVStack {
                                        ForEach(toDoItems.indices, id: \.self) { index in
                                            HStack {
                                                Toggle("", isOn: $toDoItems[index].isDone)
                                                    .labelsHidden()
                                                    .toggleStyle(CheckBoxStyle())
                                                Text(toDoItems[index].title)
                                                    .font(Font.custom("Poppins-Regular",size: 15))
                                                    .foregroundColor(.gray)
                                                Spacer()
                                            }
                                            .padding()
                                            .background(Color.white)
                                        } 
                                    }
                                }
                                .frame(height: 300)
                                .background(Color.white)
                                .cornerRadius(20)
                                .overlay(RoundedRectangle(cornerRadius: 20)  .stroke().foregroundStyle(.linearGradient(colors: [.white.opacity(0.8),.clear ], startPoint: .topLeading, endPoint: .bottomTrailing)))
                                .shadow(color: .black.opacity(0.4), radius: 10, y: 10)
                                .padding(.bottom,150)
                                .padding([.leading, .trailing],10)
                                .padding()

                    
                    
                }
                
                
            }
        }.onAppear {
            Task {
                do {
                    toDoItems = try await authViewModel.fetchToDoItems()
                } catch {
                    print("Failed to fetch to-do items: \(error)")
                }
            }
        }
        
        
        
        .ignoresSafeArea()
    }
    
    struct AddNewItemView: View {
        @EnvironmentObject var viewModel: AuthViewModel
        @Binding var isAddingItem: Bool
        @Binding var toDoItems: [ToDoItem]
        @State private var newItemTitle = ""

        var body: some View {
            VStack {
                TextField("Enter item title", text: $newItemTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    // Create a new ToDoItem with the entered title
                    let newItem = ToDoItem(title: newItemTitle, isDone: false)
                    Task {
                        do {
                            try await viewModel.addToDoItem(newItem)
                            toDoItems = try await viewModel.fetchToDoItems()
                        } catch {
                            print("Failed to fetch to-do items: \(error)")
                        }
                    }
                       

                    // Close the modal
                    isAddingItem = false
                }) {
                    Text("Add Item")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("task"))
                        .cornerRadius(10)
                }
                .padding()
            }
        }
    }
    
}

#Preview {
    TaskView()
}

struct CheckBoxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            if !configuration.isOn {
                Image( systemName: "square")
                    .foregroundColor( .black)
            } else {
                Image( systemName: "circle.fill")
                    .foregroundColor( Color("task"))
               
            }
        }
    }
}


