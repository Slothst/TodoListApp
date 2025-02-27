//
//  CustomNavigationBar.swift
//  TodoListApp
//
//  Created by 최낙주 on 2/26/25.
//

import SwiftUI

struct CustomNavigationBar: View {
    let isLeftBtnDisplay: Bool
    let isRightBtnDisplay: Bool
    let leftBtnAction: () -> Void
    let rightBtnAction: () -> Void
    let rightBtnType: NavigationBtnType
    
    init(isLeftBtnDisplay: Bool = true,
         isRightBtnDisplay: Bool = true,
         leftBtnAction: @escaping () -> Void = {},
         rightBtnAction: @escaping () -> Void = {},
         rightBtnType: NavigationBtnType = .edit
    ) {
        self.isLeftBtnDisplay = isLeftBtnDisplay
        self.isRightBtnDisplay = isRightBtnDisplay
        self.leftBtnAction = leftBtnAction
        self.rightBtnAction = rightBtnAction
        self.rightBtnType = rightBtnType
    }
    
    var body: some View {
        HStack {
            if isLeftBtnDisplay {
                Button {
                    leftBtnAction()
                } label: {
                    Image(systemName: "arrow.left")
                }
            }
            
            Spacer()
            
            if isRightBtnDisplay {
                Button {
                    rightBtnAction()
                } label: {
                    if rightBtnType == .close {
                        Image(systemName: "xmark")
                    } else {
                        Text(rightBtnType.rawValue)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 20)
        .tint(Color.orange)
    }
}

#Preview {
    CustomNavigationBar()
}
