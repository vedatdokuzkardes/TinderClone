//
//  LoginView.swift
//  TinderClone
//
//  Created by Vedat Dokuzkardeş on 15.12.2023.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    BrandingImage()
                    
                    Text("Login")
                        .font(.largeTitle)
                        .padding()
                    
                    VStack(spacing: 32) {
                        TinderInputField(imageName: "envelope", placeholderText: "email", text: $viewModel.email)
                        TinderInputField(imageName: "lock", placeholderText: "password", text: $viewModel.password, isSecureField: true)
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
                    
                    Button{
                        Task{
                            try await viewModel.login()
                        }
                    }label: {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(Color(.systemBlue))
                            .clipShape(Capsule())
                    }
                    .shadow(color: .gray.opacity(0.5), radius: 10 , x: 0, y: 0)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
                    
                    Spacer()
                    
                    NavigationLink{
                        RegisterView()
                            .navigationBarHidden(true)
                        
                    } label: {
                        HStack{
                            Text("Don't have an account?")
                                .font(.footnote)
                            Text("Sign up")
                                .font(.footnote)
                                .bold()
                        }
                    }
                    .padding(.bottom, 48)
                    .foregroundColor(.blue)
                }
                
                if $viewModel.isLoading.wrappedValue {
                    LoadingOverlayView()
                }
            }
            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            .background(colorScheme == .dark ? Color.black : Color.white)
        }
    }
}


#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}
