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
    
    private var isPasswordValid: Bool {
        !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword
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

                            Text("सुरक्षित पासवर्ड राख्नुहोस्")
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
                                Text("पासवर्ड लेख्नुहोस्")
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

                            VStack(alignment: .leading, spacing: 10) {
                                Text("पासवर्ड पुन लेख्नुहोस्")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(isDarkMode ? .white.opacity(0.8) : .secondary)

                                HStack(spacing: 0) {
                                    Group {
                                        if showConfirmPassword {
                                            TextField("", text: $confirmPassword)
                                                .font(.system(size: 16, weight: .regular))
                                                .foregroundColor(isDarkMode ? .white : Color(.label))
                                        } else {
                                            SecureField("", text: $confirmPassword)
                                                .font(.system(size: 16, weight: .regular))
                                                .foregroundColor(isDarkMode ? .white : Color(.label))
                                        }
                                    }
                                    .autocapitalization(.none)
                                    .padding(16)
                                    .padding(.trailing, 8)
                                    .focused($focusedField, equals: .confirm)

                                    Spacer(minLength: 0)

                                    Button(action: { withAnimation { showConfirmPassword.toggle() } }) {
                                        Image(systemName: showConfirmPassword ? "eye.fill" : "eye.slash.fill")
                                            .font(.system(size: 16))
                                            .foregroundColor(isDarkMode ? .white.opacity(0.6) : .secondary)
                                    }
                                    .frame(width: 44, height: 44)
                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(focusedField == .confirm
                                              ? (isDarkMode ? Color.white.opacity(0.2) : Color(.systemGray5))
                                              : (isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground)))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(focusedField == .confirm
                                                ? (isDarkMode ? Color.white.opacity(0.3) : Color(.systemGray3))
                                                : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)),
                                               lineWidth: focusedField == .confirm ? 1.5 : 1)
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
                            .disabled(!isPasswordValid)
                            .opacity(isPasswordValid ? 1.0 : 0.8)
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
