import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                LinearGradient(
                    gradient: Gradient(colors: [.black, .gray]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                // Centered header layer
                VStack(spacing: 20) {
                    Image(systemName: "film.stack.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.white)

                    Text("Moodframe")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text("Find movies that match how you feel")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal)

                // Bottom-right button layer
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink {
                            HomeView()
                        } label: {
                            Text("Get Started")
                                .fontWeight(.semibold)
                                .frame(width: 200, height: 45)
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(12)
                        }
                    }
                    .padding([.trailing, .bottom], 20)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
