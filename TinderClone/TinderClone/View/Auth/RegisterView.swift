//
//  RegisterView.swift
//  TinderClone
//
//  Created by Vedat Dokuzkardeş on 15.12.2023.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var startRegistrationFlow = false
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            VStack {
                BrandingImage()
                
                Text("Register")
                    .font(.largeTitle)
                    .padding()
                
                VStack(spacing: 32) {
                    TinderInputField(imageName: "envelope", placeholderText: "email", text: $viewModel.email)
                    TinderInputField(imageName: "person", placeholderText: "name", text: $viewModel.name)
                    TinderInputField(imageName: "lock", placeholderText: "password", text: $viewModel.password, isSecureField: true)
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 16)
                
                Button{
                    Task{
                        try await viewModel.register() {
                            startRegistrationFlow.toggle()
                        }
                    }
                }label: {
                    Text("Register")
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
                
                Button{
                    presentationMode.wrappedValue.dismiss()
                }label: {
                    HStack{
                        Text("Already registered?")
                            .font(.footnote)
                        Text("Log in")
                            .font(.footnote)
                            .bold()
                    }
                }
                .padding(.bottom, 48)
            }
            
            if $viewModel.isLoading.wrappedValue {
                LoadingOverlayView()
            }
        }
        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
        .background(colorScheme == .dark ? Color.black : Color.white)
        .alert(viewModel.errorEvent.content ,isPresented: $viewModel.errorEvent.display){
            Button("OK", role: .cancel) { }
        }
        .navigationDestination(isPresented: $startRegistrationFlow) {
            RegisterImageView()
                .navigationBarBackButtonHidden()
                
        }
    }
}


#Preview {
    RegisterView()
        .environmentObject(AuthViewModel())
}
