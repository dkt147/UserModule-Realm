import Foundation
import RealmSwift

class RealmManager: ObservableObject{
    private(set) var localRealm: Realm?
    @Published private(set) var users: [User] = []
    
    init(){
        openRealm()
        getUser()
    }
    
    func openRealm(){
        do{
            
            //Migration closure will be used in order to update the schema ever time...
            let config = Realm.Configuration(schemaVersion:1)
            Realm.Configuration.defaultConfiguration = config
            
            localRealm = try Realm()
        }catch{
            print("Error in opening Realm: \(error)")
        }
    }
    
    
    func addUser(UserName: String,UserEmail: String,UserPassword: String,UserDepart: String)
    {
        if let localRealm = localRealm {
            do{
                try localRealm.write{
                    let newUser = User(value: ["name":UserName, "email":UserEmail,"password":UserPassword, "depart":UserDepart ])
                    localRealm.add(newUser)
                    getUser()
                    print("Added new user to realm: \(newUser)")
                }
            }catch{
                print("Error in adding task\(error)")
            }
        }
    }
    
    func getUser(){
        if let localRealm = localRealm {
            let allUser = localRealm.objects(User.self).sorted(byKeyPath: "id")
            users = []
            allUser.forEach{
                task in users.append(task)
            }
        }
    }
    
        func loginUser(email: String, password: String)
        {
            if let localRealm = localRealm {
                do{
                    let getUserEmail = localRealm.objects(User.self).filter(NSPredicate(format: "email == %@", email))
                    let getUserPassword = localRealm.objects(User.self).filter(NSPredicate(format: "password == %@", password))
                    
                    guard !getUserEmail.isEmpty else {
                        return
                    }
                    guard !getUserPassword.isEmpty else {
                        return
                    }
    
                    try localRealm.write{
                        print("Login Success")
                    }
                }catch{
                    print("Login Failed \(error)")
                }
            }
        }
    
//    func updateUser(id: ObjectId, status: Bool)
//    {
//        if let localRealm = localRealm {
//            do{
//                let updateUser = localRealm.objects(User.self).filter(NSPredicate(format: "id == %@", id))
//                guard !updateUser.isEmpty else {
//                    return
//                }
//
//                try localRealm.write{
//                    updateUser[0].status = status
//                    getTasks()
//                    print("Updated task successfully")
//                }
//            }catch{
//                print("Error in updating \(error)")
//            }
//        }
//    }
    
    
    
    
    func deleteUser(id: ObjectId) {
          if let localRealm = localRealm {
              do {
                  let deleteUser = localRealm.objects(User.self).filter(NSPredicate(format: "id == %@", id))
                  guard !deleteUser.isEmpty else { return }
                  
                  try localRealm.write {
                      localRealm.delete(deleteUser)
                      getUser()
                      print("Deleted task with id \(id)")
                  }
              } catch {
                  print("Error deleting task \(id) to Realm: \(error)")
              }
          }
      }
}
