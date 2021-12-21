//
//  ContentView.swift
//  SwiftUI-Realm
//
//  Created by JOEYCO-0072PK on 20/12/2021.
//

import SwiftUI


struct Signup: View {

    //Environment variable for realm database...
    @EnvironmentObject var realmManager : RealmManager
    
    //Variable to get the value from textfields...
    @State private var name:String = ""
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var depart:String = ""
    
    //Variable to dismiss the signup page...
    @Environment (\.dismiss) var dismiss
    
    
    var body: some View {
        
        //Body of Signup Page...
        VStack(spacing:20){
            Image("logo")
                .resizable()
                .aspectRatio(contentMode:.fill)
                .frame(width: 100, height: 100)
                .padding(.bottom,20)
                .padding(.top,50)
            Text("Signup")
                .fontWeight(.heavy)
                .font(.title2)
                .frame(alignment:.leading)
                .padding(.trailing,230)
                .padding(.bottom,10)
            
            TextField("Full Name", text: $name)
                .padding()
                .padding(.leading,30)
                .padding(.trailing,30)
                .background(lightGray)
                .cornerRadius(5.0)
                .foregroundColor(.black)
            
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
            
            TextField("Department", text: $depart)
                .padding()
                .padding(.leading,30)
                .padding(.trailing,30)
                .background(lightGray)
                .cornerRadius(5.0)
                .foregroundColor(.black)
            
           
            
           
            Button{
                
                //Calling Add User Function...
                if name != ""
                {
                    realmManager.addUser(UserName: name, UserEmail: email, UserPassword: password, UserDepart: depart)
                    
                }
                //Setting fields to empty again...
                name = ""
                email = ""
                password = ""
                depart = ""
                
                //Dismiss function to dismiss the pop up...
                dismiss()
            }label: {
                Text("Signup")
                    .frame(width: 280, height: 45)
                    .foregroundColor(.white)
                    .background(.orange)
                .cornerRadius(20)
                .font(.title3)
            }.padding(.top,20)
            
            HStack{
                Text("Don't have an account?")
                Button{
                    print("Signup OK")
                }label: {
                    Text("Login now!")
                        .foregroundColor(.green)
                }
            }
                Spacer()
        }.padding()
        .padding()
    }
}

struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        Signup()
            .environmentObject(RealmManager())
        
    }
}
