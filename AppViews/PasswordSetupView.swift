import SwiftUI

struct PasswordSetupView: View {
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showPassword: Bool = false
    @State private var showConfirmPassword: Bool = false
    @Environment(\.colorScheme) private var colorScheme
    @FocusState private var focusedField: Field?

    private var isDarkMode: Bool { colorScheme == .dark }

    enum Field {
        case password, confirm
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

                            Text("Epahichan मा स्वागत छ")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(isDarkMode ? .white : .primary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 24)

                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("पासवर्ड राख्नुहोस्")
                                    .font(.subheadline)
                                    .foregroundColor(focusedField == .password ? Color.activeBlue : (isDarkMode ? .white.opacity(0.8) : .secondary))

                                HStack(spacing: 0) {
                                    Group {
                                        if showPassword {
                                            TextField("", text: $password)
                                                .font(.body)
                                                .foregroundColor(isDarkMode ? .white : .primary)
                                        } else {
                                            SecureField("", text: $password)
                                                .font(.body)
                                                .foregroundColor(isDarkMode ? .white : .primary)
                                        }
                                    }
                                    .autocapitalization(.none)
                                    .padding(16)
                                    .padding(.trailing, 8)
                                    .focused($focusedField, equals: .password)

                                    Spacer(minLength: 0)

                                    Button(action: { withAnimation { showPassword.toggle() } }) {
                                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                            .font(.system(size: 16))
                                            .foregroundColor(isDarkMode ? .white.opacity(0.6) : .secondary)
                                    }
                                    .frame(width: 44, height: 44)
                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(focusedField == .password ? Color.activeBlue : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)), lineWidth: focusedField == .password ? 2 : 1)
                                )
                            }

                            VStack(alignment: .leading, spacing: 8) {
                                Text("पासवर्ड पुन लेख्नुहोस्")
                                    .font(.subheadline)
                                    .foregroundColor(focusedField == .confirm ? Color.activeBlue : (isDarkMode ? .white.opacity(0.8) : .secondary))

                                HStack(spacing: 0) {
                                    Group {
                                        if showConfirmPassword {
                                            TextField("", text: $confirmPassword)
                                                .font(.body)
                                                .foregroundColor(isDarkMode ? .white : .primary)
                                        } else {
                                            SecureField("", text: $confirmPassword)
                                                .font(.body)
                                                .foregroundColor(isDarkMode ? .white : .primary)
                                        }
                                    }
                                    .autocapitalization(.none)
                                    .padding(16)
                                    .padding(.trailing, 8)
                                    .focused($focusedField, equals: .confirm)

                                    Spacer(minLength: 0)

                                    Button(action: { withAnimation { showConfirmPassword.toggle() } }) {
                                        Image(systemName: showConfirmPassword ? "eye.slash.fill" : "eye.fill")
                                            .font(.system(size: 16))
                                            .foregroundColor(isDarkMode ? .white.opacity(0.6) : .secondary)
                                    }
                                    .frame(width: 44, height: 44)
                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(focusedField == .confirm ? Color.activeBlue : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)), lineWidth: focusedField == .confirm ? 2 : 1)
                                )
                            }

                            NavigationLink(destination: DashboardView()) {
                                Text("सुरक्षित गर्नुहोस्")
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
        .navigationTitle("पासवर्ड")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }

}

#Preview {
    NavigationView {
        PasswordSetupView()
    }
}
