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

// MARK: - Step Indicator
struct StepIndicatorView: View {
    let current: Int
    let total: Int
    @Environment(\.colorScheme) private var colorScheme

    private var isDarkMode: Bool { colorScheme == .dark }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(1...total, id: \.self) { step in
                HStack(spacing: 0) {
                    ZStack {
                        Circle()
                            .fill(step <= current ? Color.activeBlue : Color.clear)
                            .frame(width: 44, height: 44)
                        Circle()
                            .stroke(
                                step <= current ? Color.activeBlue : (isDarkMode ? Color.white.opacity(0.25) : Color(.separator)),
                                lineWidth: step == current ? 2.5 : 1.5
                            )
                            .frame(width: 44, height: 44)
                        if step < current {
                            Image(systemName: "checkmark")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        } else {
                            Text("\(step)")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(step == current ? .white : (isDarkMode ? .white.opacity(0.5) : .secondary))
                        }
                    }
                    .frame(width: 44, height: 44)
                    if step < total {
                        Rectangle()
                            .fill(step < current ? Color.activeBlue : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)))
                            .frame(height: 2)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .padding(.horizontal, 8)
    }
}
