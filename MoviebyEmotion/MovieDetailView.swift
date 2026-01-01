import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    // Needed to open YouTube / Safari
    @Environment(\.openURL) private var openURL

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.black, .gray.opacity(0.8)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    // MARK: - Poster
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white.opacity(0.06))
                            .frame(height: 300)

                        if let url = movie.posterURL {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .tint(.white)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                case .failure:
                                    Text("Poster unavailable")
                                        .foregroundColor(.gray)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                    }

                    // MARK: - Title
                    Text(movie.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    // MARK: - Meta info (rating + year)
                    HStack(spacing: 12) {
                        if let rating = movie.voteAverage {
                            Label(
                                String(format: "%.1f", rating),
                                systemImage: "star.fill"
                            )
                            .foregroundColor(.yellow)
                        }

                        if let year = releaseYear(from: movie.releaseDate) {
                            Text(year)
                                .foregroundColor(.gray)
                        }

                        Spacer()
                    }
                    .font(.subheadline)

                    // MARK: - Overview
                    if let overview = movie.overview,
                       !overview.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Text(overview)
                            .font(.body)
                            .foregroundColor(.gray)
                    } else {
                        Text("No description available.")
                            .foregroundColor(.gray)
                    }

                    // MARK: - Trailer Button (Phase 1)
                    Button {
                        if let url = youtubeSearchURL(for: movie.title) {
                            openURL(url)
                        }
                    } label: {
                        Text("Watch Trailer")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, minHeight: 45)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(12)
                    }

                    Spacer(minLength: 10)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Helpers

    /// Creates a YouTube search URL for the movie trailer
    private func youtubeSearchURL(for title: String) -> URL? {
        let query = "\(title) official trailer"
        guard let encoded = query.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        ) else { return nil }

        return URL(
            string: "https://www.youtube.com/results?search_query=\(encoded)"
        )
    }

    /// Extracts release year from "YYYY-MM-DD"
    private func releaseYear(from date: String?) -> String? {
        guard let date, date.count >= 4 else { return nil }
        return String(date.prefix(4))
    }
}
