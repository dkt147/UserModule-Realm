
import Foundation
import RealmSwift

class User: Object, ObjectKeyIdentifiable{
    
    //Initalizing our Database schema here...
    @Persisted(primaryKey:true) var id: ObjectId
    @Persisted var name = ""
    @Persisted var email = ""
    @Persisted var password = ""
    @Persisted var depart = ""
}
