import Foundation

final class TMDBService {
    static let shared = TMDBService()
    private init() {}

    func fetchMovies(for mood: Mood) async throws -> [Movie] {
        var components = URLComponents(string: "https://api.themoviedb.org/3/discover/movie")!

        var items: [URLQueryItem] = [
            .init(name: "api_key", value: Secrets.tmdbApiKey),
            .init(name: "language", value: "en-US"),
            .init(name: "include_adult", value: "false"),
            .init(name: "include_video", value: "false"),
            .init(name: "sort_by", value: "popularity.desc"),
            .init(name: "vote_count.gte", value: "500") // helps avoid random unknown movies
        ]

        if let genres = mood.genres, !genres.isEmpty {
            items.append(.init(name: "with_genres", value: genres.map(String.init).joined(separator: ",")))
        }

        if let minRating = mood.minRating {
            items.append(.init(name: "vote_average.gte", value: String(minRating)))
        }

        // For era vibes: filter by primary release date range
        if let from = mood.yearFrom {
            items.append(.init(name: "primary_release_date.gte", value: "\(from)-01-01"))
        }
        if let to = mood.yearTo {
            items.append(.init(name: "primary_release_date.lte", value: "\(to)-12-31"))
        }

        components.queryItems = items

        let url = components.url!
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decoded = try JSONDecoder().decode(TMDBMovieResponse.self, from: data)
        return decoded.results
    }
}
