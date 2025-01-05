//
//  IngoPageView.swift
//  Pinch
//
//  Created by k21047kk on 2025/01/05.
//

import SwiftUI

struct InfoPanelView: View {
  var scale: CGFloat
  var offset: CGSize
  
  @State private var isInfoPanelVisible: Bool = false
  
  let hapticFeedback = UINotificationFeedbackGenerator()
  
    var body: some View {
      HStack{
        // MARK: - HOTSPOT
        Image(systemName: "circle.circle")
          .symbolRenderingMode(.hierarchical)
          .resizable()
          .frame(width: 30, height: 30)
          .onLongPressGesture(minimumDuration: 0.5) {
            withAnimation(.easeOut) {
              hapticFeedback.notificationOccurred(.success)
              isInfoPanelVisible.toggle()
            }
          }
        
        Spacer()
        
        
        // MARK: - INFO PANEL
        
        HStack(spacing: 2) {
          Image(systemName: "arrow.up.left.and.arrow.down.right")
            
          Text("\(scale)")
          
          Spacer()
            
          Image(systemName: "arrow.left.and.arrow.right")
          Text("\(offset.width)")
          
          Spacer()
          
          Image(systemName: "arrow.up.and.arrow.down")
          
          Text("\(offset.height)")
                
          Spacer()
        }
        .font(.footnote)
        .padding(8)
        .background(.ultraThinMaterial)
        .cornerRadius(8)
        .frame(maxWidth: 420)
        .opacity(isInfoPanelVisible ? 1 : 0)
        
        Spacer()
      }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
  InfoPanelView(scale: 1, offset: .zero)
    .preferredColorScheme(.dark)
    .padding()
}
