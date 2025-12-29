import SwiftUI

struct PosterCardView: View {
    let movie: Movie

    var body: some View {
        ZStack(alignment: .bottomLeading) {

            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white.opacity(0.06))
                .frame(width: 120, height: 180)

            if let url = movie.posterURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.white.opacity(0.08))
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.white.opacity(0.08))
                            .overlay(Text("No poster").font(.caption2).foregroundColor(.gray))
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 120, height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }

            Text(movie.title)
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .lineLimit(2)
                .padding(10)
                .background(Color.black.opacity(0.35))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(8)
        }
    }
}

//Test for github

