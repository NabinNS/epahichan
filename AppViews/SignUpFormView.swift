import SwiftUI

struct SignUpFormView: View {
    @State private var phoneNumber: String = ""
    @Environment(\.colorScheme) private var colorScheme
    @FocusState private var isPhoneFocused: Bool

    private var isDarkMode: Bool { colorScheme == .dark }
    
    private var isPhoneNumberEmpty: Bool {
        phoneNumber.trimmingCharacters(in: .whitespaces).isEmpty
    }

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

                            Text("साइन अप गर्नुहोस्")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(isDarkMode ? .white : .primary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 24)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            hideKeyboard()
                        }

                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("फोन नम्बर लेख्नुहोस्")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(isDarkMode ? .white.opacity(0.8) : .secondary)

                                TextField("98XXXXXXXX", text: $phoneNumber)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(isDarkMode ? .white : Color(.label))
                                    .keyboardType(.phonePad)
                                    .padding(16)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(isPhoneFocused 
                                                  ? (isDarkMode ? Color.white.opacity(0.2) : Color(.systemGray5))
                                                  : (isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground)))
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(isPhoneFocused 
                                                    ? (isDarkMode ? Color.white.opacity(0.3) : Color(.systemGray3))
                                                    : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)), 
                                                   lineWidth: isPhoneFocused ? 1.5 : 1)
                                    )
                                    .focused($isPhoneFocused)
                            }

                            HStack(alignment: .firstTextBaseline, spacing: 4) {
                                Text("फोन नम्बर छैन भने ")
                                    .font(.footnote)
                                    .foregroundColor(isDarkMode ? .white.opacity(0.7) : .secondary)
                                NavigationLink(destination: EmailEntryView()) {
                                    Text("इमेल बाट साइन अप गर्नुहोस्")
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
                            .disabled(isPhoneNumberEmpty)
                            .opacity(isPhoneNumberEmpty ? 0.8 : 1.0)
                            
                            HStack(spacing: 4) {
                                Spacer()
                                Text("पहिले नै खाता छ?")
                                    .font(.subheadline)
                                    .foregroundColor(isDarkMode ? .white.opacity(0.7) : .secondary)
                                NavigationLink(destination: LoginFormView()) {
                                    Text("लगइन गर्नुहोस्")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.activeBlue)
                                }
                                Spacer()
                            }
                            .padding(.top, 8)

                        }
                        .padding(.horizontal, 24)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            hideKeyboard()
                        }

                        Spacer().frame(height: 40)
                    }
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
        .navigationTitle("साइन अप")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }

}

#Preview {
    NavigationView {
        SignUpFormView()
    }
}
