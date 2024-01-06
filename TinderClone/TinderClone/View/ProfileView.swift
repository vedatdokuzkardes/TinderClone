//
//  ProfileView.swift
//  TinderClone
//
//  Created by Vedat Dokuzkardeş on 30.12.2023.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    var user: User
    var editMode = false
    @State private var showEditProfile = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading) {
                
                ZStack(alignment: .bottomTrailing) {
                    if let imageUrl = user.profileImageUrl {
                        KFImage(URL(string: imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.size.width, height: 450)
                            .clipped()
                    }else{
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.size.width, height: 450)
                            .background(.gray)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            .clipped()
                        
                    }
                    
                    if editMode{
                        Image(systemName: "pencil")
                            .resizable()
                            .padding()
                            .background(.cyan)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            .frame(width: 70, height: 70)
                            .containerShape(Circle())
                            .offset(x: -20, y: 40)
                            .onTapGesture {
                                showEditProfile.toggle()
                            }
                    }
                }
                HStack{
                    Text(user.name)
                        .font(.largeTitle)
                        .bold()
                    if let age = user.age{
                        Text(String(age))
                            .font(.title)
                    }
                }
                .padding()
                
                Divider()
                
                Text("About me")
                    .font(.title)
                    .padding()
                if let bio = user.bio{
                    Text(bio)
                        .padding()
                }
                
                Divider()
                
                Text("Interests")
                    .font(.title)
                    .padding()
                
                let gridItems: [GridItem] = [
                    .init(.flexible(), spacing: 1),
                    .init(.flexible(), spacing: 1),
                    .init(.flexible(), spacing: 1)
                ]
                
                LazyVGrid(columns: gridItems, spacing: 10) {
                    ForEach(user.interests, id: \.self) { item in
                        Text(item)
                            .padding()
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            .background(.clear)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray, lineWidth: 1))
                    }
                }
                .padding()
                
                HStack{
                    Spacer()
                    
                    Button{
                        AuthService.shared.signout()
                    }label: {
                        Text("Sign Out")
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            .background(colorScheme == .dark ? Color.black : Color.white)
        }
        .ignoresSafeArea(edges: [.top])
        .fullScreenCover(isPresented: $showEditProfile){
            EditProfileView(user: user)
        }
    }
}

#Preview {
    ProfileView(user: User.mockUsers[0], editMode: true)
}
