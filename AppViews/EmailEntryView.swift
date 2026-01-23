import SwiftUI

struct EmailEntryView: View {
    @State private var email: String = ""
    @Environment(\.colorScheme) private var colorScheme
    @FocusState private var isEmailFocused: Bool

    private var isDarkMode: Bool { colorScheme == .dark }

    var body: some View {
        ZStack {
            FormBackgroundGradient()
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: 40)

                    VStack(spacing: 32) {
                        VStack(spacing: 20) {
                            Image("SplashLogo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120)
                                .shadow(color: Color.accentViolet.opacity(0.3), radius: 20, x: 0, y: 10)

                            Text("Epahichan मा स्वागत छ")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(isDarkMode ? .white : .primary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 24)

                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("इमेल लेख्नुहोस्")
                                    .font(.subheadline)
                                    .foregroundColor(isEmailFocused ? Color.activeBlue : (isDarkMode ? .white.opacity(0.8) : .secondary))

                                TextField("", text: $email)
                                    .font(.body)
                                    .foregroundColor(isDarkMode ? .white : .primary)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                    .padding(16)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(isEmailFocused ? Color.activeBlue : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)), lineWidth: isEmailFocused ? 2 : 1)
                                    )
                                    .focused($isEmailFocused)
                            }

                            HStack(alignment: .firstTextBaseline, spacing: 4) {
                                Text("इमेल छैन भने ")
                                    .font(.footnote)
                                    .foregroundColor(isDarkMode ? .white.opacity(0.7) : .secondary)
                                NavigationLink(destination: SignUpFormView()) {
                                    Text("फोन नम्बर बाट साइन अप गर्नुहोस्")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.activeBlue)
                                }
                            }

                            NavigationLink(destination: EmailOTPView()) {
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

                        Spacer().frame(height: 40)
                    }
                }
            }
        }
        .navigationTitle("इमेल")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }

}

#Preview {
    NavigationView {
        EmailEntryView()
    }
}
