import SwiftUI

struct HomeView: View {

    @StateObject private var vm = HomeViewModel()

    private let moods: [Mood] = [
       

        Mood(
            title: "In my healing era",
            subtitle: "Soft movies that feel like a reset.",
            icon: "leaf.fill",
            genres: [18, 10749, 10751],
            yearFrom: nil, yearTo: nil,
            minRating: 6.8
        ),
        Mood(
            title: "Laugh until I cry",
            subtitle: "Comedy release, chaos & comfort.",
            icon: "face.smiling.fill",
            genres: [35],
            yearFrom: nil, yearTo: nil,
            minRating: 6.3
        ),
        Mood(
            title: "Miss being a kid",
            subtitle: "Magic, warmth, safe nostalgia.",
            icon: "sparkles",
            genres: [16, 10751, 12, 14],
            yearFrom: nil, yearTo: nil,
            minRating: 6.3
        ),
        Mood(
            title: "That 2000s energy",
            subtitle: "Peak 2000–2009 vibes.",
            icon: "opticaldisc.fill",
            genres: [35, 10749, 10402],
            yearFrom: 2000, yearTo: 2009,
            minRating: 6.0
        )
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
                VStack(alignment: .leading, spacing: 22) {
                    Text("Moodframe")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 10)

                    Text("Pick a vibe — scroll through matches.")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    ForEach(moods) { mood in
                        MoodSectionView(
                            mood: mood,
                            movies: vm.moviesByMood[mood] ?? [],
                            isLoading: vm.loadingMoods.contains(mood)
                        )
                        .task {
                            await vm.loadIfNeeded(for: mood)
                        }
                    }
                }
                .padding()
            }
        }
    }
}
