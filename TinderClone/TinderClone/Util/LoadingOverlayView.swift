//
//  LoadingOverlayView.swift
//  TinderClone
//
//  Created by Vedat Dokuzkardeş on 16.12.2023.
//

import SwiftUI

struct LoadingOverlayView: View {
    var body: some View {
        VStack{
            HStack{
                Spacer()
            }
            Spacer()
            ProgressView()
            Spacer()
        }
        .background(Color.black.opacity(0.25))
    }
}

#Preview {
    LoadingOverlayView()
}
