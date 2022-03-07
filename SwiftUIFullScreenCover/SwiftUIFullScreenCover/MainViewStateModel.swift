//
//  MainViewState.swift
//  SwiftUIDemoCenterButtom
//
//  Created by YICHAO LI on 2022/3/7.
//

import SwiftUI

class MainViewStateModel: ObservableObject {
    @Published var isMainViewPresent: Bool = false
    @Published var isBackgroundBlurEffect: Bool = false
    @Published var blurRadius: CGFloat = 0
    @Published var viewOffsetY: CGFloat = 0
    @Published var cornerRadius: CGFloat = 30
}
