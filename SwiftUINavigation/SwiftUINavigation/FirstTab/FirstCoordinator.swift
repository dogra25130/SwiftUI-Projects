//
//  FirstCoordinator.swift
//  SwiftUINavigation
//
//  Created by Abhishek Dogra on 27/01/24.
//

import Foundation
class FirstCoordinator: BaseRouter {
    enum Destination: Hashable {
        case livingRoom
        case bedroom(owner: String)
    }
    
    func navigate(to destination: Destination) {
        super.navigate(to: destination)
    }
}
