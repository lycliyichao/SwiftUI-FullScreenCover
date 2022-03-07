//
//  MainView.swift
//  SwiftUIDemoCenterButtom
//
//  Created by YICHAO LI on 2022/3/7.
//

import SwiftUI

struct MainView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var mainViewStateModel : MainViewStateModel
    
    var body: some View {
        // if mainView have not be showed, will be an emptyView
        if mainViewStateModel.isMainViewPresent {
            ZStack {
                if mainViewStateModel.isBackgroundBlurEffect {
                    Blur(style: backgounrdBlurEffect(ColorSchemeType: colorScheme))
                        .opacity((UIScreen.main.bounds.height-mainViewStateModel.viewOffsetY)/UIScreen.main.bounds.height)
                }
                
                MainContentView()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                    .background(Color.red)
                    .cornerRadius(mainViewStateModel.cornerRadius, corners: .topLeft)
                    .cornerRadius(mainViewStateModel.cornerRadius, corners: .topRight)
                    .offset(y: mainViewStateModel.viewOffsetY)
                    .gesture(
                        DragGesture()
                            .onChanged({val in
                                // 如果val大于 50 就进入页面滑动模式
                                if val.translation.animatableData.second > 50 {
                                    mainViewStateModel.viewOffsetY = val.translation.animatableData.second
                                    // 给予背景模糊量数据
                                    mainViewStateModel.blurRadius = 5 * (UIScreen.main.bounds.height - val.translation.animatableData.second) / UIScreen.main.bounds.height
                                    // 计算切角
                                    if val.translation.animatableData.second < 300 {
                                        withAnimation(.linear) {
                                            mainViewStateModel.cornerRadius = val.translation.animatableData.second / 300 * 30
                                        }
                                    } else if val.translation.animatableData.second >= 300 {
                                        mainViewStateModel.cornerRadius = 30
                                    } else {
                                        mainViewStateModel.cornerRadius = 0
                                    }
                                }
                            })
                            .onEnded({val in
                                withAnimation(.linear){
                                    mainViewStateModel.blurRadius = 0
                                }
                                // 滑动结束时 y轴滑动距离大于100给予关闭 （并清零记录的y轴移动量避免下次打开页面时位置错误）
                                if val.translation.animatableData.second > 100 || mainViewStateModel.viewOffsetY > (UIScreen.main.bounds.height * 0.35){
                                    withAnimation(.easeInOut){
                                        mainViewStateModel.viewOffsetY = UIScreen.main.bounds.height
                                        presentationMode.wrappedValue.dismiss()
                                        mainViewStateModel.isMainViewPresent = false
                                    }
                                } else {
                                    withAnimation(.easeInOut) {
                                        mainViewStateModel.viewOffsetY = 0
                                    }
                                }
                            })
                    )
            }
            .transition(.move(edge: .bottom))
            .animation(.easeIn(duration: 0.3))
            .ignoresSafeArea()// fix top blank area
        } else {
            EmptyView()
        }
        
    }
    
    func backgounrdBlurEffect(ColorSchemeType: ColorScheme) -> UIBlurEffect.Style {
        if ColorSchemeType == .light {
            return .systemChromeMaterialDark
        } else {
            return .systemChromeMaterialLight
        }
    }
}

struct MainContentView : View {
    var body: some View {
        Text("Hello World")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
