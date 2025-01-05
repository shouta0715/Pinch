//
//  ContentView.swift
//  Pinch
//
//  Created by k21047kk on 2025/01/05.
//

import SwiftUI

struct ContentView: View {
  // MARK: - PROPERTIES
  
  @State private var isAnimating: Bool = false
  
  @State private var imageScale: CGFloat = 1.0
  
  @State private var imageOffset: CGSize = .zero
  
  
  
  // MARK: - FUNCTION
  
  func resetImageState() {
    return withAnimation(.spring()) {
      imageScale = 1
      imageOffset = .zero
    }
  }
  
  // MARK: - CONTENT
    var body: some View {
      NavigationView {
        ZStack {
          Color.clear
          // MARK: - PAGE IMAGE
          Image(.magazineFrontCover)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
            .padding()
            .shadow(color: .black.opacity((0.2)), radius: 12,x: 2,y: 2)
            .opacity(isAnimating ? 1 : 0)
            .offset(imageOffset)
            .scaleEffect(imageScale)
          // MARK: - 1. TAP GESTURE
            .onTapGesture(count: 2, perform:{
              if imageScale == 1 {
                withAnimation(.spring()) {
                  imageScale = 5
                }
              } else {
                resetImageState()
              }
            })
          // MARK: - 2. Drag gesture
            .gesture(
              DragGesture()
                .onChanged({ info in
                  withAnimation(.linear(duration: 1)) {
                    imageOffset = info.translation
                  }
              })
                .onEnded { _ in
                  if imageScale <= 1 {
                    resetImageState()
                  }
                }
            )
        } //: ZStack
        .navigationTitle("Pinch & Zoom")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
          withAnimation(.linear(duration: 1.0)) {
            isAnimating = true
          }
        })
        // MARK: - INFO PANEL
        .overlay(alignment: .top) {
          InfoPanelView(scale: imageScale, offset: imageOffset)
            .padding(.horizontal)
            .padding(.top, 30)
        }
        // MARK: - CONTROLS
        .overlay(alignment: .bottom) {
          Group {
            HStack {
              // SCALE DOWN
              
              Button {
                withAnimation(.spring()) {
                  if imageScale > 1 {
                    imageScale -= 1
                    
                    if imageScale <= 1 {
                      resetImageState()
                    }
                  }
                }
              } label: {
                ControlImage(icon: "minus.magnifyingglass")
              }
              
              // RESET
              
              Button {
                withAnimation(.spring()) {
                  resetImageState()
                }
              } label: {
                ControlImage(icon: "arrow.up.left.and.down.right.magnifyingglass")
              }
              
              // SCALE UP
              
              Button {
                withAnimation(.spring()) {
                  if imageScale < 5 {
                    imageScale += 1
                  }
                }
              } label: {
                ControlImage(icon: "plus.magnifyingglass")
              }
              
            } //: CONTROLS
            .padding(EdgeInsets(top:12, leading:20, bottom:12, trailing:20))
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .opacity(isAnimating ? 1 : 0)
            
          }
          .padding(.bottom,30)
        }
      } //: Navigation
      .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
