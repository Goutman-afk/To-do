//
//  ContentView.swift
//  To-do
//
//  Created by Hoành Long on 18/10/2023.
//

import SwiftUI
import  Combine

struct LoginView: View {
    @State private var isCreateButtonClicked = false
    @State private var username = ""
    @State private var pass = ""
    @State private var showError: Bool = false
      @State private var errorMessage: String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
                  ZStack {
                      HeaderFooter(isCreateButtonClicked: $isCreateButtonClicked)
                      if isCreateButtonClicked {
                         NavigationLink(destination: RegisterView().environmentObject(viewModel), isActive: $isCreateButtonClicked) {
                             EmptyView()
                         }
                      } else {
                         SignView
                      }
                  }
                 
              }
        .alert(isPresented: $showError) {
                       Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                   }
    }
    var SignView : some View {
        ScrollView  {
            VStack {
                VStack {
                    Text("Hello")
                        .font(.system(size: 60))
                        .foregroundColor(Color.black)
                        .bold()
                    Text("Sign in to your account")
                        .font(.title3)
                        .foregroundColor(Color.black.opacity(0.8))
                        .padding(.top, -20)
                }
                    .padding(.top, 100)
           
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
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 5)
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
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 5)
                        .padding(.top,40)
                    
                    Text("Forgot your password?")
                        .font(.system(size: 15))
                        .foregroundColor(Color.black.opacity(0.5))
                        .padding(.trailing, -120)
                        .padding(.top, 20)
                    HStack {
                        Text("Sign in")
                            .font(.system(size: 30))
                            .foregroundColor(Color.black)
                        .bold()
                        
                        Button {
                            Task {
                                do {
                                         
                                      try await viewModel.signIn(withEmail: username, password: pass)
                            } catch {
                                       errorMessage = error.localizedDescription
                                       showError = true

                                   }
                              }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: 60, height: 40)
                                .foregroundStyle(.linearGradient(colors: [Color("PurpleCustom").opacity(0.4),Color("BlueCustom").opacity(0.8) ], startPoint: .topLeading, endPoint: .bottomTrailing))
                                Image(systemName: "arrow.forward")
                                    .foregroundColor(Color.white)
                                    .padding()
                                
                            }
                          
                        }
                        
                   
                            
                        
                    }
                                .padding(.trailing, -120)
                                .padding(.top, 100)
                             
                 
                   
                    
                } .gesture(TapGesture().onEnded{
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                  to:nil, from:nil, for:nil)
                  })
              
                Spacer()
                
                HStack {
                    Text("Don’t have an account?")
                    Button(action: {
                        isCreateButtonClicked.toggle()
                                   }) {
                                       Text("Create").underline()
                                   }
                }.font(.system(size: 17))
                    .foregroundColor(Color.black)
                .padding(.bottom,50)
              
            }
        }.scrollIndicators(.hidden)
        
        
        
    }

}
struct HeaderFooter: View {
    @Binding var isCreateButtonClicked: Bool
    var body: some View {
      
        VStack{
            UpperIcon()
                .frame(width: 391, height: 119)
                .foregroundStyle(.linearGradient(colors: [Color("PurpleCustom").opacity(0.5),Color("PurpleCustom") ], startPoint: .topLeading, endPoint: .bottomTrailing))
                .padding(.leading, isCreateButtonClicked ?  -300 : 0 )
                .animation(.easeInOut)
            Spacer()
            LowerIcon()
                .frame(width: 369, height: 305)
               
                .foregroundStyle(.linearGradient(colors: [Color("PinkCustom").opacity(0.8),Color("BlueCustom").opacity(0.8) ], startPoint: .topLeading, endPoint: .bottomTrailing))
                .rotationEffect(Angle.degrees(isCreateButtonClicked ?  -20 : 10))
                .padding(.leading, isCreateButtonClicked ?  -150 : -200)
                .padding(.bottom,  isCreateButtonClicked ?  -30 : 2)
               
                .animation(.easeInOut)
        }
        .ignoresSafeArea()
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct LowerIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: -1.70146*width, y: 0.93331*height))
        path.addCurve(to: CGPoint(x: -1.22906*width, y: 1.21452*height), control1: CGPoint(x: -1.66713*width, y: 1.0854*height), control2: CGPoint(x: -1.48264*width, y: 1.28109*height))
        path.addCurve(to: CGPoint(x: -1.03424*width, y: 0.93185*height), control1: CGPoint(x: -1.03738*width, y: 1.1642*height), control2: CGPoint(x: -1.25749*width, y: 1.03997*height))
        path.addCurve(to: CGPoint(x: -0.29552*width, y: 0.93079*height), control1: CGPoint(x: -0.81097*width, y: 0.82374*height), control2: CGPoint(x: -0.48455*width, y: 0.81338*height))
        path.addCurve(to: CGPoint(x: -0.21502*width, y: 1.23015*height), control1: CGPoint(x: -0.15632*width, y: 1.01724*height), control2: CGPoint(x: -0.33065*width, y: 1.1332*height))
        path.addCurve(to: CGPoint(x: 0.99419*width, y: 1.01912*height), control1: CGPoint(x: 0.05076*width, y: 1.45303*height), control2: CGPoint(x: 1.02829*width, y: 1.29115*height))
        path.addCurve(to: CGPoint(x: 0.41169*width, y: 0.70321*height), control1: CGPoint(x: 0.9716*width, y: 0.8388*height), control2: CGPoint(x: 0.57619*width, y: 0.85528*height))
        path.addCurve(to: CGPoint(x: 0.17956*width, y: 0.16007*height), control1: CGPoint(x: 0.21181*width, y: 0.51845*height), control2: CGPoint(x: 0.4626*width, y: 0.30604*height))
        path.addCurve(to: CGPoint(x: -0.53701*width, y: 0.03267*height), control1: CGPoint(x: -0.03448*width, y: 0.04968*height), control2: CGPoint(x: -0.27172*width, y: -0.0496*height))
        path.addCurve(to: CGPoint(x: -0.39065*width, y: 0.57698*height), control1: CGPoint(x: -0.88154*width, y: 0.13952*height), control2: CGPoint(x: -0.06798*width, y: 0.44966*height))
        path.addCurve(to: CGPoint(x: -0.84551*width, y: 0.62651*height), control1: CGPoint(x: -0.54056*width, y: 0.63613*height), control2: CGPoint(x: -0.6659*width, y: 0.62192*height))
        path.addCurve(to: CGPoint(x: -1.39859*width, y: 0.58402*height), control1: CGPoint(x: -1.06506*width, y: 0.63213*height), control2: CGPoint(x: -1.19576*width, y: 0.53186*height))
        path.addCurve(to: CGPoint(x: -1.70146*width, y: 0.93331*height), control1: CGPoint(x: -1.64441*width, y: 0.64725*height), control2: CGPoint(x: -1.73463*width, y: 0.78636*height))
        path.closeSubpath()
        return path
    }
}
struct UpperIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.23583*width, y: 0.99955*height))
        path.addCurve(to: CGPoint(x: 0.02063*width, y: 0.61575*height), control1: CGPoint(x: 0.14021*width, y: 0.98661*height), control2: CGPoint(x: 0.11626*width, y: 0.62884*height))
        path.addCurve(to: CGPoint(x: -0.00256*width, y: 0.61575*height), control1: CGPoint(x: 0.01158*width, y: 0.61451*height), control2: CGPoint(x: -0.00256*width, y: 0.61575*height))
        path.addLine(to: CGPoint(x: -0.00256*width, y: 0))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addCurve(to: CGPoint(x: 0.86598*width, y: 0.50188*height), control1: CGPoint(x: width, y: 0), control2: CGPoint(x: 0.93346*width, y: 0.36409*height))
        path.addCurve(to: CGPoint(x: 0.49485*width, y: 0.50188*height), control1: CGPoint(x: 0.74302*width, y: 0.75297*height), control2: CGPoint(x: 0.63356*width, y: 0.36439*height))
        path.addCurve(to: CGPoint(x: 0.23583*width, y: 0.99955*height), control1: CGPoint(x: 0.38259*width, y: 0.61315*height), control2: CGPoint(x: 0.35303*width, y: 1.01539*height))
        path.closeSubpath()
        return path
    }
    
    
}

