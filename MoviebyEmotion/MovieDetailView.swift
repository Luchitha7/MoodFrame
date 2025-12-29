import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.black, .gray.opacity(0.8)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 16) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        Text("Poster")
                            .foregroundColor(.white.opacity(0.8))
                    )
                    .frame(height: 260)

                Text(movie.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text("Movie description will go here (from TMDB).")
                    .font(.body)
                    .foregroundColor(.gray)

                Button {
                    // YouTube trailer
                } label: {
                    Text("Watch Trailer")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, minHeight: 45)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(12)
                }

                Spacer()
            }
            .padding()
        }
    }
}
