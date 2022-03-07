//
//  ContentView.swift
//  SwiftUIDemoCenterButtom
//
//  Created by YICHAO LI on 2022/3/7.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var mainViewStateModel : MainViewStateModel

    var body: some View {
        ContentMainView()
            .overlay( MainView() )
            .statusBar(hidden: true)
    }
}

struct ContentMainView : View {
    @EnvironmentObject var mainViewStateModel : MainViewStateModel
    
    var body: some View {
        ZStack {
            Button(action: {
                if mainViewStateModel.viewOffsetY >= UIScreen.main.bounds.height {
                    mainViewStateModel.isMainViewPresent = false
                    mainViewStateModel.viewOffsetY = 0
                    mainViewStateModel.cornerRadius = 0
                }
                mainViewStateModel.isMainViewPresent.toggle()
            }, label: {
                Circle()
                    .frame(width: 80, height: 80, alignment: .center)
                    .foregroundColor(.orange.opacity(0.8))
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
