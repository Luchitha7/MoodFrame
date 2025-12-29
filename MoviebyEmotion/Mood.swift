import SwiftUI

struct Mood: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String

    
    let genres: [Int]?
    let yearFrom: Int?
    let yearTo: Int?
    let minRating: Double?
}
