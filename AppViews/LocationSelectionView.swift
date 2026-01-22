import SwiftUI

struct LocationSelectionView: View {
    @State private var searchText: String = ""
    @State private var selectedLocation: String?
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isSearchFocused: Bool

    private var isDarkMode: Bool { colorScheme == .dark }

    let locations = [
        "काठमाडौं, केंद्रीय कार्यालय",
        "ललितपुर, कार्यालय",
        "भक्तपुर, कार्यालय",
        "पोखरा, कार्यालय",
        "चितवन, कार्यालय",
        "बिराटनगर, कार्यालय",
        "धरान, कार्यालय",
        "बुटवल, कार्यालय",
        "हेटौडा, कार्यालय",
        "नारायणगढ, कार्यालय",
        "भक्तपुर, कार्यालय",
        "पोखरा, कार्यालय",
        "चितवन, कार्यालय",
        "बिराटनगर, कार्यालय",
        "धरान, कार्यालय",
        "बुटवल, कार्यालय",
        "हेटौडा, कार्यालय",
        "नारायणगढ, कार्यालय"
    ]

    var filteredLocations: [String] {
        searchText.isEmpty
            ? locations
            : locations.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        ZStack {
            FormBackgroundGradient()
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: 40)
                    VStack(spacing: 32) {
                        VStack(spacing: 16) {
                            StepIndicatorView(current: 5, total: 5)
                                .padding(.horizontal, 24)
                            ZStack {
                                Circle()
                                    .fill(Color.activeBlue.opacity(0.15))
                                    .frame(width: 80, height: 80)
                                Image(systemName: "mappin.circle.fill")
                                    .font(.system(size: 36, weight: .semibold))
                                    .foregroundColor(Color.activeBlue)
                            }
                            VStack(spacing: 8) {
                                Text("प्रमाणीकरण ईस्थान छान्नुहोस्")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(isDarkMode ? .white : .primary)
                                    .multilineTextAlignment(.center)
                                Text("तपाईं प्रमाणीकरण गर्न चाहनुहुन्ने ईस्थान छान्नुहोस्")
                                    .font(.subheadline)
                                    .foregroundColor(isDarkMode ? .white.opacity(0.7) : .secondary)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 8)
                            }
                        }
                        .padding(.top, 24)

                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("स्थान खोज्नुहोस्")
                                    .font(.subheadline)
                                    .foregroundColor(isSearchFocused ? Color.activeBlue : (isDarkMode ? .white.opacity(0.8) : .secondary))
                                HStack(spacing: 12) {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(isDarkMode ? .white.opacity(0.6) : .secondary)
                                    TextField("स्थान खोज्नुहोस्", text: $searchText)
                                        .font(.body)
                                        .foregroundColor(isDarkMode ? .white : .primary)
                                        .focused($isSearchFocused)
                                }
                                .padding(16)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(isSearchFocused ? Color.activeBlue : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)), lineWidth: isSearchFocused ? 2 : 1)
                                )
                            }

                            ScrollView {
                                VStack(spacing: 12) {
                                    ForEach(filteredLocations, id: \.self) { location in
                                        Button(action: { selectedLocation = location }) {
                                            HStack {
                                                Text(location)
                                                    .font(.body)
                                                    .foregroundColor(isDarkMode ? .white : .primary)
                                                Spacer()
                                                Image(systemName: selectedLocation == location ? "checkmark.circle.fill" : "circle")
                                                    .font(.system(size: 22))
                                                    .foregroundColor(selectedLocation == location ? Color.activeBlue : (isDarkMode ? .white.opacity(0.4) : .secondary))
                                            }
                                            .padding(16)
                                            .background(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
                                            )
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(selectedLocation == location ? Color.activeBlue : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)), lineWidth: selectedLocation == location ? 2 : 1)
                                            )
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                            .frame(maxHeight: 280)

                            HStack(spacing: 12) {
                                Button(action: { dismiss() }) {
                                    HStack(spacing: 8) {
                                        Image(systemName: "chevron.left")
                                            .font(.system(size: 16, weight: .semibold))
                                        Text("पछाडि जानुहोस्")
                                            .font(.system(size: 18, weight: .semibold))
                                    }
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 56)
                                    .background(isDarkMode ? Color.white.opacity(0.25) : Color(.systemGray))
                                    .cornerRadius(14)
                                }
                                .buttonStyle(.plain)
                                NavigationLink(destination: VerificationDetailView()) {
                                    Text("अगाडि बढ्नुहोस्")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 56)
                                        .background(Color.activeBlue)
                                        .cornerRadius(14)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 24)
                        Spacer().frame(height: 40)
                    }
                }
            }
        }
        .navigationTitle("स्थान छान्नुहोस्")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView { LocationSelectionView() }
}
