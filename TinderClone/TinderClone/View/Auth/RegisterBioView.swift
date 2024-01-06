//
//  RegisterBioView.swift
//  TinderClone
//
//  Created by Vedat Dokuzkardeş on 30.12.2023.
//

import SwiftUI

struct RegisterBioView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Text("Step 4 of 6")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding()
            Text("Hey, \(viewModel.currentUser?.name ?? "")")
                .font(.title)
                .padding()
            Text("Write a few words about yourself")
                .font(.headline)
                .padding()
            
            Divider()

            TextEditor(text: $viewModel.bio)
                .frame(width: 300, height: 150, alignment: .topLeading)
                .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.gray, lineWidth: 1)
                
                )
                .padding()
            
            NavigationLink {
                RegisterInterestsView()
                    .navigationBarBackButtonHidden()
            } label: {
                Text("Next")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 44)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                
            }
            .padding()
            
            Button{
                viewModel.skipRegistrationFlow()
                dismiss()
            } label: {
                Text("Skip for now")
            }
            .foregroundColor(.gray)
            
            Spacer()
        }
        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
        .background(colorScheme == .dark ? Color.black : Color.white)
    }
}

#Preview {
    RegisterBioView()
        .environmentObject(AuthViewModel())
}
