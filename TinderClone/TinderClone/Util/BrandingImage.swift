//
//  BrandingImage.swift
//  TinderClone
//
//  Created by Vedat Dokuzkardeş on 15.12.2023.
//

import SwiftUI

struct BrandingImage: View {
    
    var size: CGFloat = 150
    
    var body: some View {
        Image("fire")
            .resizable()
            .frame(width: size, height: size)
            .padding()
    }
}

#Preview {
    BrandingImage()
}
