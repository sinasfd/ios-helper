//
//  AppDelegate.swift
//  bonizfood
//
//  Created by sina salehifard on 8/5/18.
//  Copyright © 2018 ofogheshahr. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    public static var tell:String = ""
    public static  var pass:String = ""
    public static var fullname:String = ""
    public static var curentViewController:UIViewController?
    public static var delivery:Int = 0
    public static var offShop:Int = 0
    public static var minOrderPrice:Int = 0
    
    public static var payStatus:String?
    public static var payAuthorty:String?
    
    
    
    internal static var  slides:[StructSlider] = []
    internal static var  shops:[StructShop] = []
    internal static var  comments:[StructComent] = []
    internal static var  searchShops:[StructShop] = []
    internal static var  shopCategory:[StructCategory] = []
    internal static var  productCategory:[StructCategory] = []
    internal static var  products:[StructProduct] = []
    internal static var  basket:[StructBasket] = []
    internal static var  address:[StructAddress] = []
    internal static var  order:[StructOrder] = []
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      //  sleep(2)
        
        
       AppConfig.configTabel()
        
        
        
        return true
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let message = url.host?.removingPercentEncoding
        let arr = message?.characters.split(separator: "&").map(String.init)
        AppDelegate.payStatus = arr?[0]
        AppDelegate.payAuthorty = arr?[1]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PAYEMNT_NOTIFICATION"), object: nil)

        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

