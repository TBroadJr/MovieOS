//
//  HomeView.swift
//  MovieOS
//
//  Created by Tornelius Broadwater, Jr on 12/10/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var manager: Manager
    @State private var showMenu = false
    @State private var showMovieDetail = false
    @State private var selectedMovieID: Int = 0
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                buttonSection
                userInfoSection
                nowShowingSection
                comingSoonSection
            }
            .frame(maxHeight: .infinity, alignment: .top)
            backgroundTint
            menuSection
            
            if showMovieDetail {
                showDetail
            }
        }
        .onAppear {
            manager.fetchMovieIDs()
        }
        .statusBarHidden()
    }
}

private extension HomeView {
 
    // MARK: - Button Section
    private var buttonSection: some View {
        HStack {
            Button {
                withAnimation {
                    showMenu = true
                }
                print("menu")
            } label: {
                Image(systemName: "line.3.horizontal.decrease")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.primary)
            }
            .padding(.horizontal, 30)
            Spacer()
            Button {
                print("search")
            } label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.primary)
            }
            .padding(.horizontal, 30)

        }
    }
    
    // MARK: - User Info Section
    private var userInfoSection: some View {
        HStack {
            Image("person")
                .resizable()
                .frame(width: 75, height: 75)
            
            Text("Hi Lily!")
                .font(.system(size: 24, weight: .semibold))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
    }
    
    // MARK: - Now Showing Section
    private var nowShowingSection: some View {
        MovieDisplaySection(manager: manager, sectionTitle: "Now Showing", movieItems: manager.movieItems, selectedMovieID: $selectedMovieID, showMovieDetail: $showMovieDetail)
    }
    
    // MARK: - Coming Soon Section
    private var comingSoonSection: some View {
        MovieDisplaySection(manager: manager, sectionTitle: "Coming Soon", movieItems: manager.movieItems, selectedMovieID: $selectedMovieID, showMovieDetail: $showMovieDetail)
    }
    
    // MARK: - Menu Section
    private var menuSection: some View {
        MenuSection(showMenu: $showMenu)
            .shadow(color: .black.opacity(0.3), radius: 5, x: 5, y: 0)
            .offset(x: showMenu ? -100 : -500)
    }
    
    // MARK: - Background Tint
    private var backgroundTint: some View {
        Color.clear
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.ultraThinMaterial)
            .opacity(showMenu ? 1 : 0)
    }
    
    // MARK: - Show Detail
    private var showDetail: some View {
        ForEach(manager.movies) { item in
            if item.id == selectedMovieID {
                MovieDetailScreen(showMovieDetail: $showMovieDetail, movie: item)
                    .zIndex(1)
            }
        }
    }
}

// MARK: - Poster Image
struct PosterImage:  View {
    var posterPath: String
    var body: some View {
        ImageLoader(url: URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")!) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
            case .failure(_):
                Color.gray
            @unknown default:
                EmptyView()
            }
        }
    }
}

// MARK: - Movie Display Section
struct MovieDisplaySection: View {
    var manager: Manager
    var sectionTitle: String
    var movieItems: [MovieItem]
    @Binding var selectedMovieID: Int
    @Binding var showMovieDetail: Bool
    var body: some View {
        VStack(spacing: 20) {
            Text(sectionTitle)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(movieItems) { item in
                        Button {
                            manager.fetchMovie(id: "\(item.id)")
                            withAnimation {
                                selectedMovieID = item.id
                                showMovieDetail = true
                            }
                        } label: {
                            VStack(spacing: 5) {
                                PosterImage(posterPath: item.posterPath)
                                    .frame(width: 175, height: 225)
                                    .shadow(color: Color("Shadow").opacity(0.2), radius: 10, x: 0, y: 15)
                                VStack(spacing: 5) {
                                    Text(item.title)
                                        .font(.system(size: 12, weight: .semibold, design: .serif))
                                        .foregroundColor(.primary)
                                        .multilineTextAlignment(.center)

                                    
                                    Text("\(item.rating.formatted(.number)) / 10")
                                        .font(.system(size: 10, weight: .semibold))
                                        .foregroundColor(.secondary)
                                }
                                .frame(width: 165)
                            }
                        }
                    }
                }
            }
            .frame(height: 275)
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - Menu Display
struct MenuSection: View {
    @Binding var showMenu: Bool
    var body: some View {
        ZStack {
            Color("Shadow").ignoresSafeArea()
            
            VStack(spacing: 30) {
                userSection
                Group {
                    MenuItem(imageName: "tag.fill", text: "Promotion Code")
                    MenuItem(imageName: "textformat", text: "Select A Language")
                    MenuItem(imageName: "doc.plaintext.fill", text: "Terms of Service")
                    MenuItem(imageName: "questionmark.circle.fill", text: "Help")
                    MenuItem(imageName: "star.circle.fill", text: "Rate Us")
                }
                .padding(.horizontal, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
            .padding(.leading, 100)
        }
        .overlay {
            xmarkButton
                .ignoresSafeArea()
                .padding(.leading, 100)
        }
    }
    
    private var xmarkButton: some View {
        Button {
            withAnimation {
                showMenu = false
            }
        } label: {
            XMarkImage()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(20)
    }
    
    private var userSection: some View {
        HStack {
            Image("person")
                .resizable()
                .frame(width: 75, height: 75)
            VStack {
                Text("Lily Johnson")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                Text("LilyJohnson@gmail.com")
                    .font(.system(size: 15, weight: .medium))
                    .accentColor(.white)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

// MARK: - Menu Item
struct MenuItem: View {
    var imageName: String
    var text: String
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 30, height: 30)
            Text(text)
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(.white)
        }
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(width: 250)
        .background(.ultraThinMaterial)
        .mask(RoundedRectangle(cornerRadius: 10))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Manager())
    }
}
