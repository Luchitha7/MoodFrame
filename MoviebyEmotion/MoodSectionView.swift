import SwiftUI

struct MoodSectionView: View {
    let mood: Mood
    let movies: [Movie]
    let isLoading: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(mood.title)
                        .font(.headline)
                        .foregroundColor(.white)

                    Text(mood.subtitle)
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()

                NavigationLink {
                    SeeMoreView(mood: mood, movies: movies)
                } label: {
                    Text("See more")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.white.opacity(0.12))
                        .cornerRadius(10)
                }
                .disabled(movies.isEmpty)
                .opacity(movies.isEmpty ? 0.5 : 1)
            }

            if isLoading && movies.isEmpty {
                // loading 
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(0..<6, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.white.opacity(0.08))
                                .frame(width: 120, height: 180)
                        }
                    }
                }
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(movies.prefix(12), id: \.id) { movie in
                            NavigationLink {
                                MovieDetailView(movie: movie)
                            } label: {
                                PosterCardView(movie: movie)
                            }
                        }
                    }
                    .padding(.vertical, 2)
                }
            }
        }
    }
}
