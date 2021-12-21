//
//  ContentView.swift
//  SwiftUI-Realm
//
//  Created by JOEYCO-0072PK on 20/12/2021.
//

import SwiftUI

//Adding custom color...
let lightGray = Color(red:239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0)


struct Login: View {
    
    //Variable for alert...
    @State private var showAlert = false
    @State private var AddSignup = false
    
    //Environment variable for realm database...
    @EnvironmentObject var realmManager : RealmManager
    
    //Variable to get the value from textfields...
    @State private var email:String = ""
    @State private var password:String = ""
    
    var body: some View {
        
        //Body of Login Page...
        VStack(spacing:20){
            Image("logo")
                .resizable()
                .aspectRatio(contentMode:.fill)
                .frame(width: 100, height: 100)
                .padding(.bottom,20)
                .padding(.top,40)
            Text("Login")
                .fontWeight(.heavy)
                .font(.title2)
                .frame(alignment:.leading)
                .padding(.trailing,250)
                .padding(.bottom,10)
            
            TextField("Email", text: $email)
                .padding()
                .padding(.leading,30)
                .padding(.trailing,30)
                .background(lightGray)
                .cornerRadius(5.0)
                .foregroundColor(.black)
            
            SecureField("Password", text: $password)
                .padding()
                .padding(.leading,30)
                .padding(.trailing,30)
                .background(lightGray)
                .cornerRadius(5.0)
                .foregroundColor(.black)
            
           
            
            Button{
                print("Forgot OK")
            }label: {
                Text("Forgot Password?")
                    .foregroundColor(.green)
                    .padding(.leading,160)
            }
            
            Button{
                
                //Calling login funciton on tap...
                if email != ""
                {
                    realmManager.loginUser(email: email, password: password)
                    
                }
                
                //Setting fields to empty again...
                email = ""
                password = ""
            }
        label: {
                Text("Login")
                    .frame(width: 280, height: 45)
                    .foregroundColor(.white)
                    .background(.orange)
                .cornerRadius(20)
                .font(.title3)
            }.padding(.top,20)
            
            
            HStack{
                Text("Don't have an account?")
                Button{
                    //Opening signup page on click as a popup sheet...
                    AddSignup.toggle()
                }label: {
                    Text("Sign up now!")
                        .foregroundColor(.green)
                }.sheet(isPresented: $AddSignup)
                {
                    Signup()
                        .environmentObject(realmManager)

                }
            }.padding(.top, 100)
                Spacer()
        }.padding()
        .padding()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
            .environmentObject(RealmManager())
        
    }
}
