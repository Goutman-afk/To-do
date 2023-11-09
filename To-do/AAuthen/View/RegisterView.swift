//
//  RegisterView.swift
//  To-do
//
//  Created by Hoành Long on 09/11/2023.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var isCreateButtonClicked = false
    @State private var username = ""
    @State private var pass = ""
    @State private var phone = ""
    @State private var email = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            VStack {
                Text("Create account")
                    .font(.system(size: 30))
                    .foregroundColor(Color.black)
                    .bold()
               
            }
                .padding(.top, 50)
       
            VStack{
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(Color.gray.opacity(0.6))
                        .padding()
                    
                    TextField("User Name", text: $username )
                        .padding(.leading, -10)
                }
                    .frame(width: 300, height: 60)
                    .background(Color.white)
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke()
                            .foregroundStyle( Color.black.opacity(0.1)
                                            )
                    )
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 10)
                HStack {
                    Image(systemName: "exclamationmark.lock.fill")
                        .foregroundColor(Color.gray.opacity(0.6))
                        .padding()
                    SecureField("Password", text: $pass )
                        .padding(.leading, -10)
                    
                }
                    .frame(width: 300, height: 60)
                    .background(Color.white)
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke()
                            .foregroundStyle( Color.black.opacity(0.1)
                                            )
                    )
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 10)
                    .padding(.top,40)
                HStack {
                    Image(systemName: "mail")
                        .foregroundColor(Color.gray.opacity(0.6))
                        .padding()
                    TextField("Email ( optional )", text: $email )
                        .padding(.leading, -10)
                    
                }
                    .frame(width: 300, height: 60)
                    .background(Color.white)
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke()
                            .foregroundStyle( Color.black.opacity(0.1)
                                            )
                    )
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 10)
                    .padding(.top,40)
                
                HStack {
                    Image(systemName: "iphone.gen1")
                        .foregroundColor(Color.gray.opacity(0.6))
                        .padding()
                    TextField("Phone ( optional )", text: $phone )
                        .padding(.leading, -10)
                    
                }
                    .frame(width: 300, height: 60)
                    .background(Color.white)
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke()
                            .foregroundStyle( Color.black.opacity(0.1)
                                            )
                    )
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 10)
                    .padding(.top,40)
                HStack {
                    Text("Create")
                        .font(.system(size: 30))
                        .foregroundColor(Color.black)
                    .bold()
                    
                    
                    
                    
                    Button(action: {
                        
                        Task {
                            try await  viewModel.createUser(withEmail: username, password: pass, phone: phone)
                        }
                   
                        isCreateButtonClicked.toggle()
                    }){
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: 60, height: 40)
                                .foregroundStyle(.linearGradient(colors: [Color("Color").opacity(0.8),Color("Color 1").opacity(0.8) ], startPoint: .topLeading, endPoint: .bottomTrailing))
                            Image(systemName: "arrow.forward")
                                .foregroundColor(Color.white)
                                .padding()
                            
                        }
                    }
                        
                    
                }
                            .padding(.trailing, -120)
                            .padding(.top, 30)
                
            }
            .padding(20.0)
            
            Spacer()
            
            VStack {
                Text("Or create account using social media")
            }.font(.system(size: 17))
                .foregroundColor(Color.black)
                .padding(.bottom,10)
            
            HStack{
                
                Image(systemName: "f.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(Color.blue.opacity(0.6))
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5)
                    .padding()
                Image(systemName: "g.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(Color.orange.opacity(0.6))
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5)
                    .padding()
                Image(systemName: "bird.fill")
                    .font(.system(size: 30))
                    .foregroundColor(Color.red.opacity(0.6))
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5)
                    .padding()
                
            }  .padding(.bottom,100)
            
            
        }
    }
}

#Preview {
    RegisterView()
}
