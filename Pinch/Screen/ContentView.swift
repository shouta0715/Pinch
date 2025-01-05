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
      } //: Navigation
      .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
