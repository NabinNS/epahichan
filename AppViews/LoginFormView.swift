import SwiftUI

// MARK: - Color Extensions
extension Color {
    static let accentViolet = Color(red: 208/255, green: 188/255, blue: 255/255)
    static let activeBlue = Color(red: 0/255, green: 59/255, blue: 149/255) // #003b95
}

// MARK: - LoginFormView
struct LoginFormView: View {
    @State private var emailOrPhone: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @Environment(\.colorScheme) private var colorScheme
    @FocusState private var focusedField: Field?

    private var isDarkMode: Bool { colorScheme == .dark }

    enum Field {
        case email, password
    }

    var body: some View {
        ZStack {
            FormBackgroundGradient()
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 0) {
                        Spacer().frame(height: 40)

                        VStack(spacing: 32) {
                            // MARK: Logo & Welcome
                            VStack(spacing: 20) {
                                Image("SplashLogo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 120, height: 120)
                                    .shadow(color: Color.accentViolet.opacity(0.3), radius: 20, x: 0, y: 10)

                                Text("E-pahichan मा स्वागत छ")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(isDarkMode ? .white : .primary)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(.top, 24)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                hideKeyboard()
                            }

                            // MARK: Input Fields
                            VStack(alignment: .leading, spacing: 20) {
                                // Email / Phone
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("इमेल वा फोन नम्बर")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(isDarkMode ? .white.opacity(0.8) : .secondary)

                                    TextField("", text: $emailOrPhone)
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundColor(isDarkMode ? .white : Color(.label))
                                        .keyboardType(.emailAddress)
                                        .autocapitalization(.none)
                                        .padding(16)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(focusedField == .email
                                                      ? (isDarkMode ? Color.white.opacity(0.2) : Color(.systemGray5))
                                                      : (isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground)))
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(focusedField == .email
                                                        ? (isDarkMode ? Color.white.opacity(0.3) : Color(.systemGray3))
                                                        : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)),
                                                       lineWidth: focusedField == .email ? 1.5 : 1)
                                        )
                                        .focused($focusedField, equals: .email)
                                }

                                // Password
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("पासवर्ड")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(isDarkMode ? .white.opacity(0.8) : .secondary)

                                    HStack(spacing: 0) {
                                        Group {
                                            if showPassword {
                                                TextField("", text: $password)
                                                    .font(.system(size: 16, weight: .regular))
                                                    .foregroundColor(isDarkMode ? .white : Color(.label))
                                            } else {
                                                SecureField("", text: $password)
                                                    .font(.system(size: 16, weight: .regular))
                                                    .foregroundColor(isDarkMode ? .white : Color(.label))
                                            }
                                        }
                                        .autocapitalization(.none)
                                        .padding(16)
                                        .padding(.trailing, 8)
                                        .focused($focusedField, equals: .password)

                                        Spacer(minLength: 0)

                                        // Show/Hide password button
                                        Button(action: { withAnimation { showPassword.toggle() } }) {
                                            Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                                                .font(.system(size: 16))
                                                .foregroundColor(isDarkMode ? .white.opacity(0.6) : .secondary)
                                        }
                                        .frame(width: 44, height: 44)
                                    }
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(focusedField == .password
                                                  ? (isDarkMode ? Color.white.opacity(0.2) : Color(.systemGray5))
                                                  : (isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground)))
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(focusedField == .password
                                                    ? (isDarkMode ? Color.white.opacity(0.3) : Color(.systemGray3))
                                                    : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)),
                                                   lineWidth: focusedField == .password ? 1.5 : 1)
                                    )
                                }

                                // Forgot Password
                                HStack {
                                    Spacer()
                                    Button(action: {}) {
                                        Text("पासवर्ड बिर्सनुभयो?")
                                            .font(.subheadline)
                                            .foregroundColor(Color.activeBlue)
                                    }
                                }
                            }
                            .padding(.horizontal, 24)

                            // MARK: Buttons
                            VStack(spacing: 16) {
                                // Login Button
                                NavigationLink(destination: DashboardView()) {
                                    Text("लगइन")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 56)
                                        .background(Color.activeBlue)
                                        .cornerRadius(14)
                                }
                                .buttonStyle(.plain)

                                // Sign Up Link
                                HStack(spacing: 4) {
                                    Text("खाता छैन?")
                                        .font(.body)
                                        .foregroundColor(isDarkMode ? .white.opacity(0.7) : .secondary)

                                    NavigationLink(destination: SignUpFormView()) {
                                        Text("साइन अप गर्नुहोस्")
                                            .font(.body)
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color.activeBlue)
                                    }
                                }
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
            .navigationTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }


#Preview {
    LoginFormView()
}
