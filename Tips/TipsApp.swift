//
//  TipsApp.swift
//  Tips
//
//  Created by Wadealanchan on 21/2/2024.
//

import SwiftUI
import RealmSwift

@main
struct TipsApp: SwiftUI.App {
    
    @State private var isActive = false
    
    init() {
         setupRealm()
     }
    
    var body: some Scene {
        WindowGroup {
            if isActive {
                MainTabBarView()
                    .environment(\.realmConfiguration, Realm.Configuration.defaultConfiguration)
            }else {
                LaunchView(isActive: $isActive)
            }
            //ExampleView()
        }
    }
    
    
    func setupRealm() {
//        let config = Realm.Configuration(
//            schemaVersion: 2, // Increment this number whenever you change the schema
//            migrationBlock: { migration, oldSchemaVersion in
//                if oldSchemaVersion < 2 {
//                    migration.enumerateObjects(ofType: TaskItem.className()) { oldObject, newObject in
//                        // Perform any necessary migration logic here
//                        newObject!["isStarred"] = false // Set default value for new property
//                    }
//                }
//            }
//        )
//        
//        Realm.Configuration.defaultConfiguration = config
    }
}
