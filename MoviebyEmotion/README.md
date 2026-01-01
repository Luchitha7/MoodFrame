import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    @Environment(\.openURL) private var openURL

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: movie.posterURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(12)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }

                HStack {
                    Text(movie.title)
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Text(movie.releaseYear)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                HStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", movie.voteAverage))
                        .fontWeight(.semibold)
                    Spacer()
                }

                Text(movie.overview)
                    .font(.body)
                    .foregroundColor(.primary)

                Button {
                    if let url = movie.trailerSearchURL {
                        openURL(url)
                    }
                } label: {
                    Text("Watch Trailer")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.gradient)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension Movie {
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }

    var releaseYear: String {
        guard let date = releaseDate, date.count >= 4 else { return "N/A" }
        return String(date.prefix(4))
    }

    var trailerSearchURL: URL? {
        let query = "\(title) trailer".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return URL(string: "https://www.youtube.com/results?search_query=\(query)")
    }
}

// Dummy Movie model for preview purposes
struct Movie {
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double

    static let example = Movie(
        title: "Inception",
        overview: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.",
        posterPath: "/qmDpIHrmpJINaRKAfWQfftjCdyi.jpg",
        releaseDate: "2010-07-16",
        voteAverage: 8.3
    )
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MovieDetailView(movie: .example)
        }
    }
}
