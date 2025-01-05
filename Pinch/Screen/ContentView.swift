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
  
  @State private var isDrawerOpen: Bool = false
  
  @State private var chevronImage: String = "chevron.compact.left"
  
  let pages: [Page] = pagesData
  @State private var pageIndex: Int = 1
  
  // MARK: - FUNCTION
  
  func resetImageState() {
    return withAnimation(.spring()) {
      imageScale = 1
      imageOffset = .zero
    }
  }
  
  func currentPageImage() -> ImageResource {
    return pages[pageIndex - 1].imageName
  }
  
  // MARK: - CONTENT
    var body: some View {
      NavigationView {
        ZStack {
          Color.clear
          // MARK: - PAGE IMAGE
          Image(currentPageImage())
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
          // MARK: - 3. Magnification gesture
            .gesture(
              MagnificationGesture()
                .onChanged {value in
                  withAnimation(.linear(duration: 1)) {
                    if imageScale >= 1 && imageScale <= 5 {
                      imageScale = value
                    } else if imageScale > 5 {
                      imageScale = 5
                    }
                  }
                }
                .onEnded { _ in
                  if imageScale > 5 {
                    imageScale = 5
                  } else if imageScale <= 1 {
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
        .overlay(alignment: .topTrailing) {
          HStack(spacing: 12) {
            // MARK: - DRAWER HANDLE
            Image(systemName: chevronImage)
              .resizable()
              .scaledToFit()
              .frame(height: 40)
              .padding(8)
              .foregroundStyle(.secondary)
              .onTapGesture {
                chevronImage = isDrawerOpen ? "chevron.compact.left" : "chevron.compact.right"
             
                withAnimation(.easeOut(duration: 0.25)) {
                    isDrawerOpen.toggle()
                }
              }
              
            // MARK: - THUNBANILS
            ForEach(pages) { item in
              Image(item.thumbnailName)
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .cornerRadius(8)
                .shadow(radius: 4)
                .opacity(isDrawerOpen ? 1 : 0)
                .animation(.easeOut(duration: 0.25), value:isDrawerOpen)
                .onTapGesture(perform: {
                  isAnimating = true
                  withAnimation {
                    pageIndex = item.id
                  }
                })
            }
            Spacer()
          }//: DRAWER
          .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
          .background(.ultraThinMaterial)
          .cornerRadius(12)
          .opacity(isAnimating ? 1 : 0)
          .frame(width: 260)
          .padding(.top, UIScreen.main.bounds.height / 12)
          .offset(x: isDrawerOpen ? 20 : 215)
        }
      } //: Navigation
      .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
