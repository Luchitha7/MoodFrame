import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var moviesByMood: [Mood: [Movie]] = [:]
    @Published var loadingMoods: Set<Mood> = []

    func loadIfNeeded(for mood: Mood) async {
        if moviesByMood[mood] != nil { return } // already loaded
        loadingMoods.insert(mood)

        do {
            let movies = try await TMDBService.shared.fetchMovies(for: mood)
            moviesByMood[mood] = movies
        } catch {
            moviesByMood[mood] = []
            print("TMDB error for \(mood.title): \(error)")
        }

        loadingMoods.remove(mood)
    }
}

