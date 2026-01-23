import SwiftUI

struct AdditionalLocationSelectionView: View {
    @State private var searchText: String = ""
    @State private var selectedLocations: [String] = []
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isSearchFocused: Bool

    private var isDarkMode: Bool { colorScheme == .dark }

    let allLocations = [
        "काठमाडौं, केंद्रीय कार्यालय",
        "ललितपुर, कार्यालय",
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
        let available = allLocations.filter { !selectedLocations.contains($0) }
        return searchText.isEmpty
            ? available
            : available.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        ZStack {
            FormBackgroundGradient()
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: 40)
                    VStack(spacing: 24) {
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.activeBlue.opacity(0.15))
                                    .frame(width: 80, height: 80)
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.system(size: 36, weight: .semibold))
                                    .foregroundColor(Color.activeBlue)
                            }
                            VStack(spacing: 8) {
                                Text("प्रमाणीकरण ईस्थान")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(isDarkMode ? .white : .primary)
                                    .multilineTextAlignment(.center)
                                Text("थप ईस्थान थप्नुहोस् वा हटाउनुहोस्")
                                    .font(.subheadline)
                                    .foregroundColor(isDarkMode ? .white.opacity(0.7) : .secondary)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 8)
                            }
                        }
                        .padding(.top, 24)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            hideKeyboard()
                        }

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

                            if !filteredLocations.isEmpty {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("उपलब्ध ईस्थान")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(isDarkMode ? .white.opacity(0.9) : .secondary)
                                    ScrollView {
                                        VStack(spacing: 10) {
                                            ForEach(filteredLocations, id: \.self) { location in
                                                Button(action: {
                                                    if !selectedLocations.contains(location) {
                                                        selectedLocations.append(location)
                                                        searchText = ""
                                                    }
                                                }) {
                                                    HStack {
                                                        Text(location)
                                                            .font(.body)
                                                            .foregroundColor(isDarkMode ? .white : .primary)
                                                        Spacer()
                                                        Image(systemName: "plus.circle.fill")
                                                            .font(.system(size: 22))
                                                            .foregroundColor(Color.activeBlue)
                                                    }
                                                    .padding(16)
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 12)
                                                            .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
                                                    )
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 12)
                                                            .stroke(isDarkMode ? Color.white.opacity(0.2) : Color(.separator), lineWidth: 1)
                                                    )
                                                }
                                                .buttonStyle(.plain)
                                            }
                                        }
                                    }
                                    .frame(maxHeight: 220)
                                }
                                .padding(16)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(isDarkMode ? Color.white.opacity(0.08) : Color(.tertiarySystemBackground))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(isDarkMode ? Color.white.opacity(0.15) : Color(.separator), lineWidth: 1)
                                )
                            }

                            VStack(alignment: .leading, spacing: 12) {
                                Text("प्रमाणीकरण को लागि पठाएको ईस्थान हरू")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(isDarkMode ? .white.opacity(0.9) : .secondary)
                                VStack(spacing: 0) {
                                    ScrollView {
                                        VStack(spacing: 10) {
                                            ForEach(selectedLocations, id: \.self) { location in
                                                HStack(spacing: 12) {
                                                    Image(systemName: "mappin.circle.fill")
                                                        .font(.system(size: 18))
                                                        .foregroundColor(Color.activeBlue)
                                                    Text(location)
                                                        .font(.body)
                                                        .foregroundColor(isDarkMode ? .white : .primary)
                                                    Spacer()
                                                    Button(action: {
                                                        selectedLocations.removeAll { $0 == location }
                                                    }) {
                                                        Text("हटाउनुहोस्")
                                                            .font(.footnote)
                                                            .fontWeight(.semibold)
                                                            .foregroundColor(.white)
                                                            .padding(.horizontal, 12)
                                                            .padding(.vertical, 8)
                                                            .background(Color.red.opacity(0.9))
                                                            .cornerRadius(10)
                                                    }
                                                }
                                                .padding(16)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
                                                )
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(Color.activeBlue.opacity(0.5), lineWidth: 1)
                                                )
                                            }
                                        }
                                        .padding(.bottom, 8)
                                    }
                                    .frame(maxHeight: 180)
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
                                        Button(action: {}) {
                                            Text("पेश गर्नुहोस्")
                                                .font(.system(size: 18, weight: .semibold))
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity)
                                                .frame(height: 56)
                                                .background(Color.activeBlue)
                                                .cornerRadius(14)
                                        }
                                    }
                                    .padding(.top, 16)
                                }
                                .padding(16)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(isDarkMode ? Color.white.opacity(0.08) : Color(.tertiarySystemBackground))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(isDarkMode ? Color.white.opacity(0.15) : Color(.separator), lineWidth: 1)
                                )
                            }
                        }
                        .padding(.horizontal, 24)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            hideKeyboard()
                        }
                        Spacer().frame(height: 40)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        hideKeyboard()
                    }
                }
                .scrollDismissesKeyboard(.interactively)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                hideKeyboard()
            }
        }
        .navigationTitle("ईस्थान थप्नुहोस्")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationView { AdditionalLocationSelectionView() }
}
