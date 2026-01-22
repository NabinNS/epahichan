import SwiftUI

struct FormBackgroundGradient: View {
    @Environment(\.colorScheme) private var colorScheme

    private var isDarkMode: Bool { colorScheme == .dark }

    var body: some View {
        Group {
            if isDarkMode {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.1, green: 0.1, blue: 0.15),
                        Color(red: 0.05, green: 0.05, blue: 0.1)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            } else {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(.systemGray6),
                        Color(.systemBackground)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
        }
    }
}
