//
//  Task.swift
//  SwiftUI-Realm
//
//  Created by JOEYCO-0072PK on 21/12/2021.
//

import Foundation
import RealmSwift

class User: Object, ObjectKeyIdentifiable{
    @Persisted(primaryKey:true) var id: ObjectId
    @Persisted var name = ""
    @Persisted var email = ""
    @Persisted var password = ""
    @Persisted var depart = ""
}
