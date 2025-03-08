//
//  WriteBtn.swift
//  TodoListApp
//
//  Created by 최낙주 on 2/27/25.
//

import SwiftUI

public struct WriteBtnViewModifier: ViewModifier {
    let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        action()
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .font(.system(size: 50))
                    }
                    .tint(Color.orange)
                }
            }
            .padding(.trailing, 20)
            .padding(.bottom, 50)
        }
    }
}

extension View {
    public func writeBtn(perform action: @escaping () -> Void) -> some View {
        ZStack {
            self
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        action()
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .font(.system(size: 50))
                    }
                    .tint(Color.orange)
                }
            }
            .padding(.trailing, 20)
            .padding(.bottom, 50)
        }
    }
}

public struct WriteBtnView<Content: View>: View {
    @ObservedObject private var viewModel: ViewModel
    let content: Content
    let action: () -> Void
    
    init(
        @ViewBuilder content: () -> Content,
        action: @escaping () -> Void,
        viewModel: ViewModel
    ) {
        self.content = content()
        self.action = action
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            content
            
            if !viewModel.isEditMode {
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            action()
                        } label: {
                            Image(systemName: "pencil.circle.fill")
                                .font(.system(size: 50))
                        }
                        .tint(Color.orange)
                    }
                }
                .padding(.trailing, 20)
                .padding(.bottom, 50)
            }
        }
    }
}
