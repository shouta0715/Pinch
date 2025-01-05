//
//  ControlImage.swift
//  Pinch
//
//  Created by k21047kk on 2025/01/05.
//

import SwiftUI

struct ControlImage: View {
  let icon: String
    var body: some View {
      Image(systemName: icon)
        .font(.system(size:36))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
  ControlImage(icon: "globe")
    .preferredColorScheme(.dark)
    .padding()
}
