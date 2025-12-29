import SwiftUI

struct SeeMoreView: View {
    let mood: Mood
    let movies: [Movie]

    private let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.black, .gray.opacity(0.8)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                LazyVGrid(columns: columns, spacing: 14) {
                    ForEach(movies) { movie in
                        NavigationLink {
                            MovieDetailView(movie: movie)
                        } label: {
                            PosterCardView(movie: movie)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(mood.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
