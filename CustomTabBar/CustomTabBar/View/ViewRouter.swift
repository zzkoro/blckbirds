//
//  ViewRouter.swift
//  CustomTabBar
//
//  Created by junemp on 2022/05/01.
//

import Foundation
import SwiftUI

class ViewRouter: ObservableObject {
    
    @Published var currentPage: Page = .home
}

enum Page {
    case home
    case liked
    case records
    case user
}
