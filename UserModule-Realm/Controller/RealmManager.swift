import Foundation

//Importing Realm Module...
import RealmSwift

//Inheriting ObservableObject Class...
class RealmManager: ObservableObject{
    
    //Declaring variable to make a connection..
    private(set) var localRealm: Realm?
    
    //Getting user data in an array of type USER...
    @Published private(set) var users: [User] = []
    
    
    //Initializer....
    init(){
        //Opening connection on load...
        openRealm()
        
        //Getting user on load...
        getUser()
    }
    
    // Function to create a connection between application and Realm...
    func openRealm(){
        do{
            
            //Migration closure will be used in order to update the schema version every time...
            let config = Realm.Configuration(schemaVersion:1)
            Realm.Configuration.defaultConfiguration = config
            
            //Using pre-defined variable to set the connection status...
            localRealm = try Realm()
        }catch{
            print("Error in opening Realm: \(error)")
        }
    }
    
    
    //Function to add user in offline database...
    func addUser(UserName: String,UserEmail: String,UserPassword: String,UserDepart: String)
    {
        //Unwrapping values safely..
        if let localRealm = localRealm {
            do{
                //Passing query to add user...
                try localRealm.write{
                    let newUser = User(value: ["name":UserName, "email":UserEmail,"password":UserPassword, "depart":UserDepart ])
                    localRealm.add(newUser)
                    
                    //Reloading state to get user..
                    getUser()
                    print("Added new user to realm: \(newUser)")
                }
            }catch{
                print("Error in adding task\(error)")
            }
        }
    }
    
    //Function to get All user data...
    func getUser(){
        
        //Unwrapping values safely..
        if let localRealm = localRealm {
            
            //Getting and sorting values based on their Id's..
            let allUser = localRealm.objects(User.self).sorted(byKeyPath: "id")
            
            //Empty array..
            users = []
            
            //Appending values to above array...
            allUser.forEach{
                task in users.append(task)
            }
        }
    }
    
    
    //Function for login User...
        func loginUser(email: String, password: String)
        {
            //Unwrapping values safely..
            if let localRealm = localRealm {
                do{
                    //Checking credentials...
                    let getUserEmail = localRealm.objects(User.self).filter(NSPredicate(format: "email == %@", email))
                    let getUserPassword = localRealm.objects(User.self).filter(NSPredicate(format: "password == %@", password))
                    
                    guard !getUserEmail.isEmpty else {
                        return
                    }
                    guard !getUserPassword.isEmpty else {
                        return
                    }
    
                    //Message on successfull login...
                    try localRealm.write{
                        print("Login Success")
                       
                    }
                }catch{
                    
                    //Message on unsuccessfull login...
                    print("Login Failed \(error)")
                }
            }
        }
    

    
}
