//
//  SwiftUIDemoCenterButtomApp.swift
//  SwiftUIDemoCenterButtom
//
//  Created by YICHAO LI on 2022/3/7.
//

import SwiftUI

@main
struct SwiftUIDemoCenterButtomApp: App {
    let mainViewStateModel: MainViewStateModel = MainViewStateModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mainViewStateModel)
        }
    }
}
