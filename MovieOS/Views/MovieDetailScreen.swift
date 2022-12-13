//
//  MovieDetailScreen.swift
//  MovieOS
//
//  Created by Tornelius Broadwater, Jr on 12/12/22.
//

import SwiftUI

struct MovieDetailScreen: View {
    @Binding var showMovieDetail: Bool
    var movie: Movie
    var body: some View {
        ZStack(alignment: .top) {
            Color("BackgroundColor").ignoresSafeArea()
            VStack {
                Text(movie.title)
                    .font(.largeTitle.weight(.semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                movieImage
                VStack(spacing: 5) {
                    Text("OVERVIEW")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                    Text(movie.overview)
                        .padding(10)
                        .background(.thickMaterial)
                        .mask(RoundedRectangle(cornerRadius: 10))
                        .padding(10)
                }
            }
        }
        .overlay {
            xmarkButton
                .ignoresSafeArea()
        }
    }
    private var xmarkButton: some View {
        Button {
            withAnimation {
                showMovieDetail = false
            }
        } label: {
            XMarkImage()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(20)
    }
    
    private var movieImage: some View {
        PosterImage(posterPath: movie.backdropPath)
            .frame(maxWidth: .infinity, maxHeight: 200)
            .shadow(color: Color("Shadow").opacity(0.2), radius: 10, x: 0, y: 15)
            .padding()
    }
}

//struct MovieDetailScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailScreen(showMovieDetail: .constant(true))
//    }
//}
