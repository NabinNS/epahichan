import SwiftUI

struct NameEntryView: View {
    @State private var nepaliName: String = ""
    @State private var englishName: String = ""
    @Environment(\.colorScheme) private var colorScheme
    @FocusState private var focusedField: Field?

    private var isDarkMode: Bool { colorScheme == .dark }

    enum Field { case nepali, english }

    var body: some View {
        ZStack {
            FormBackgroundGradient()
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: 40)
                    VStack(spacing: 32) {
                        VStack(spacing: 16) {
                            StepIndicatorView(current: 1, total: 5)
                                .padding(.horizontal, 24)
                            ZStack {
                                Circle()
                                    .fill(Color.activeBlue.opacity(0.15))
                                    .frame(width: 80, height: 80)
                                Image(systemName: "person.text.rectangle.fill")
                                    .font(.system(size: 36, weight: .semibold))
                                    .foregroundColor(isDarkMode ? .darkModeIcon : Color.activeBlue)
                            }
                            VStack(spacing: 8) {
                                Text("नाम प्रविष्टि")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(isDarkMode ? .white : .primary)
                                    .multilineTextAlignment(.center)
                                Text("पूरा नाम नेपाली र इंग्लिशमा लेख्नुहोस्")
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
                            VStack(alignment: .leading, spacing: 10) {
                                Text("पूरा नाम नेपाली मा लेख्नुहोस्")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(isDarkMode ? .white.opacity(0.8) : .secondary)
                                TextField("", text: $nepaliName)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(isDarkMode ? .white : Color(.label))
                                    .padding(16)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(focusedField == .nepali
                                                  ? (isDarkMode ? Color.white.opacity(0.2) : Color(.systemGray5))
                                                  : (isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground)))
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(focusedField == .nepali
                                                    ? (isDarkMode ? Color.white.opacity(0.3) : Color(.systemGray3))
                                                    : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)),
                                                   lineWidth: focusedField == .nepali ? 1.5 : 1)
                                    )
                                    .focused($focusedField, equals: .nepali)
                            }
                            VStack(alignment: .leading, spacing: 10) {
                                Text("पूरा नाम English मा लेख्नुहोस्")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(isDarkMode ? .white.opacity(0.8) : .secondary)
                                TextField("", text: $englishName)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(isDarkMode ? .white : Color(.label))
                                    .padding(16)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(focusedField == .english
                                                  ? (isDarkMode ? Color.white.opacity(0.2) : Color(.systemGray5))
                                                  : (isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground)))
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(focusedField == .english
                                                    ? (isDarkMode ? Color.white.opacity(0.3) : Color(.systemGray3))
                                                    : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)),
                                                   lineWidth: focusedField == .english ? 1.5 : 1)
                                    )
                                    .focused($focusedField, equals: .english)
                            }
                            NavigationLink(destination: DocumentSelectionView()) {
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
        .navigationTitle("नाम")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView { NameEntryView() }
}
