//
//  MatchView.swift
//  TinderClone
//
//  Created by Vedat Dokuzkardeş on 30.12.2023.
//

import SwiftUI

struct MatchView: View {
    
    @StateObject var viewModel = MatchViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack{
            ZStack {
                ScrollView{
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.matches) { chat in
                            NavigationLink(value: chat) {
                                let otherUserName = chat.user1.id == viewModel.currentUser?.id ? chat.user2.name : chat.user1.name
                                let otherUserProfileImage = chat.user1.id == viewModel.currentUser?.id ? chat.user2.profileImageUrl : chat.user1.profileImageUrl
                                
                                HStack{
                                    RoundImageView(imageUrl: otherUserProfileImage, imageSize: .medium)
                                    
                                    Text(otherUserName)
                                        .font(.headline)
                                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                    Spacer()
                                }
                                Divider()
                            }
                        }
                    }
                    .padding()
                    .navigationTitle("Matches")
                }
                
                if $viewModel.isLoading.wrappedValue {
                    LoadingOverlayView()
                }
            }
            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            .background(colorScheme == .dark ? Color.black : Color.white)
            .navigationDestination(for: Chat.self) { chat in
                ChatView()
                    .environmentObject(ChatViewModel(chat: chat))
            }
        }
    }
}

#Preview {
    MatchView()
}
