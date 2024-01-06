//
//  SwipeView.swift
//  TinderClone
//
//  Created by Vedat Dokuzkardeş on 13.12.2023.
//

import SwiftUI
import Kingfisher

struct SwipeView: View {
    
    @StateObject var viewModel = SwipeViewModel()
    @State var isMatch = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        
        let onlike: (_ card: Card) -> () = { card in
            Task{
                await viewModel.onLike(likeCard: card) {
                    isMatch.toggle()
                }
            }
        }
        
        let onDislike: (_ card: Card) -> () = { card in
            Task{
                await viewModel.onDislike(dislikeCard: card)
            }
        }
        
        NavigationStack {
            ZStack {
                VStack{
                    if viewModel.potentialCards.isEmpty{
                        Spacer()
                        Text("No profiles available")
                        Spacer()
                    }else{
                        ZStack{
                            ForEach(viewModel.potentialCards) { card in
                                NavigationLink(value: card) {
                                    CardView(card: card, onLike: onlike, onDislike: onDislike)
                                }
                            }
                        }
                        .navigationDestination(for: Card.self) { card in
                            ProfileView(user: card.user)
                        }
                    }
                }
                if $viewModel.isLoading.wrappedValue {
                    LoadingOverlayView()
                }
            }
            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            .background(colorScheme == .dark ? Color.black : Color.white)
            .alert("Match!", isPresented: $isMatch) {
                Button("OK", role: .cancel) {
                    isMatch.toggle()
                }
            }
        }
    }

}


struct CardView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var card: Card
    var onLike: (_ card: Card) -> ()
    var onDislike: (_ card: Card) -> ()
    let cardGradient = Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.5)])
    
    var body: some View{
        VStack{
            //card view
            ZStack(alignment: .topLeading){
                GeometryReader{ geo in
                    if let imageUrl = card.user.profileImageUrl {
                        KFImage(URL(string: imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width, height: geo.size.height)
                            .clipped()
                    }else {
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                        .foregroundColor(.white)
                }
            }
                
                LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: .bottom)
                
                VStack{
                    Spacer()
                    HStack{
                        Text(card.user.name)
                            .font(.largeTitle)
                            .bold()
                        if let age = card.user.age{
                            Text(String(age))
                                .font(.title)
                        }
                    }
                    .foregroundColor(.white)
                }
                .padding()
                
                HStack{
                    Image("like")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                        .opacity(Double(card.x / 10 - 1))
                    Spacer()
                    Image("nope")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180)
                        .opacity(Double(card.x / 10 * -1 - 1))
                }
                
            }
            .background(.black)
            .cornerRadius(16)
            .padding(8)
            .offset(x: card.x, y: card.y)
            .rotationEffect(.init(degrees: card.degree))
            .gesture(DragGesture()
            
                .onChanged({ value in
                    withAnimation(.default){
                        card.x = value.translation.width
                        card.y = value.translation.height
                        card.degree = 7 * (value.translation.width > 0 ? 1 : -1)
                    }
                })
                    .onEnded({ value in
                        withAnimation(.interpolatingSpring(mass: 1, stiffness: 50, damping: 5, initialVelocity: 0)) {
                            switch value.translation.width{
                            case 0...100:
                                card.x = 0
                                card.y = 0
                                card.degree = 0
                            case let x where x > 100:
                                card.x = 1000
                                card.degree = 12
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    onLike(card)
                                }
                            case (-100)...(-1):
                                card.x = 0
                                card.y = 0
                                card.degree = 0
                            case let x where x < -100:
                                card.x = -1000
                                card.degree = -12
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    onDislike(card)
                                }
                            default:
                                card.x = 0
                                card.y = 0
                            }
                        }
                    })
            )
            
            //buttons view
            HStack{
                Spacer()
                
                Button{
                    withAnimation(.interpolatingSpring(mass: 1, stiffness: 50, damping: 5, initialVelocity: 0)){
                        card.degree = -12
                        card.x = -1000
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            onDislike(card)
                        }
                    }
                } label: {
                    Image("dismiss").resizable().frame(width: 100, height: 100)
                }
                
                Spacer()
                
                Button{
                    withAnimation(.interpolatingSpring(mass: 1, stiffness: 50, damping: 5, initialVelocity: 0)){
                        card.degree = 12
                        card.x = 1000
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            onLike(card)
                        }
                    }
                    
                } label: {
                    Image("love").resizable().frame(width: 100, height: 100)
                }
                
                Spacer()
                
            }
            
        }
        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
        .background(colorScheme == .dark ? Color.black : Color.white)
    }
}

#Preview {
    SwipeView()
        .environmentObject(SwipeViewModel())
}
