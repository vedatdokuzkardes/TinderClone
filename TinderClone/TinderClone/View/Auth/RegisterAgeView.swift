//
//  RegisterAgeView.swift
//  TinderClone
//
//  Created by Vedat Dokuzkardeş on 30.12.2023.
//

import SwiftUI

struct RegisterAgeView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Text("Step 2 of 6")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding()
            Text("Hey, \(viewModel.currentUser?.name ?? "")")
                .font(.title)
                .padding()
            Text("Let's get some basic info on you.")
                .font(.headline)
                .padding()
            
            Divider()
           
            Text("What's your age?")
            Picker("Choose", selection: $viewModel.age) {
                ForEach(18...100, id:\.self) { age in
                    Text(String(age))
                }
            }
            
            NavigationLink {
                RegisterGenderView()
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
    RegisterAgeView()
        .environmentObject(AuthViewModel())
}
