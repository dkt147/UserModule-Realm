//
//  ContentView.swift
//  UserModule-Realm
//
//  Created by JOEYCO-0072PK on 21/12/2021.
//

import SwiftUI


struct ContentView: View {
    @StateObject var realmManager = RealmManager()
    
    var body: some View {
        
        Login()
            .environmentObject(realmManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
