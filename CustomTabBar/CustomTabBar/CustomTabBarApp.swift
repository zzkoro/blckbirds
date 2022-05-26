//
//  CustomTabBarApp.swift
//  CustomTabBar
//
//  Created by junemp on 2022/05/01.
//

import SwiftUI

@main
struct CustomTabBarApp: App {
    
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            MainView(viewRouter: viewRouter)
        }
    }
}
