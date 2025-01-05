//
//  PageModel.swift
//  Pinch
//
//  Created by k21047kk on 2025/01/05.
//

import Foundation
import SwiftUI

struct Page: Identifiable {
  let id: Int
  let imageName: ImageResource
  let thumbnailName: ImageResource
  
  init(id: Int, imageName: ImageResource, thumbnailName: ImageResource) {
    self.id = id
    self.imageName = imageName
    self.thumbnailName = thumbnailName
  }
}

