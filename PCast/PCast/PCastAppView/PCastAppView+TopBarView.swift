//
//  HomeView+HelperViews.swift
//  PCast
//
//  Created by Abhishek Dogra on 15/08/24.
//

import SwiftUI

extension PCastAppView {
    var TopBarView: some View {
        HStack {
            Group {
                Button {
                    coordinator.goBack()
                } label: {
                    if coordinator.navPath.isEmpty {
                        LogoView(logoSize: CGSize(width: 45, height: 45),
                                 fontStyle: .setFont(.medium500, 24))
                            .transition(.opacity)
                    } else {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.white)
                            .transition(.scale)
                    }
                }
                .addBounceButtonStyle()
            }
            .frame(height: 45)
            
            Spacer()
            HStack(spacing: 20) {
                Group {
                    Button {
                        setProfileState(.search)
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                    }
                    
                    Button {
                        setProfileState(.profile)
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                    }
                }
                
                .foregroundStyle(Color.white)
            }
        }
        .padding(.bottom, 8)
        .padding(.horizontal, 16)
        .opacity(topBarButton == .none ? 1 : 0)
    }
    
}

#Preview(body: {
    PCastAppView()
})
