//
//  AppDelegate.swift
//  Tudu
//
//  Created by Victor Hugo on 2/26/19.
//  Copyright © 2019 Vintage Robot. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //La siguiente línea me sirve para verificar la ubicación de los datos almacenados
        //usando UserDefaults
//        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        
        do
        {
            _ = try Realm()
            
        } catch {
            print("Error initialising new realm,\(error)")
        }
        
        
        return true
    }
    
}
