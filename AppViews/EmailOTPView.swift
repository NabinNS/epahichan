import SwiftUI

struct EmailOTPView: View {
    let email: String
    @State private var otpDigits: [String] = Array(repeating: "", count: 6)
    @FocusState private var focusedField: Int?
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss

    private var isDarkMode: Bool { colorScheme == .dark }
    
    init(email: String = "example@email.com") {
        self.email = email
    }
    
    private var isOTPComplete: Bool {
        otpDigits.allSatisfy { !$0.isEmpty }
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

                            Text("OTP प्रविष्ट गर्नुहोस्")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(isDarkMode ? .white : .primary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 24)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            hideKeyboard()
                        }

                        VStack(spacing: 20) {
                            Text("\(email) मा आएको ६ अंकको OTP लेख्नुहोस्")
                                .font(.subheadline)
                                .foregroundColor(isDarkMode ? .white.opacity(0.8) : .secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 24)

                            HStack(spacing: 12) {
                                ForEach(0..<6, id: \.self) { index in
                                    TextField("", text: Binding(
                                        get: { otpDigits[index] },
                                        set: { newValue in
                                            let filtered = newValue.filter { $0.isNumber }
                                            if filtered.count <= 1 {
                                                otpDigits[index] = filtered
                                                if filtered.count == 1, index < 5 {
                                                    focusedField = index + 1
                                                }
                                            }
                                        }
                                    ))
                                    .keyboardType(.numberPad)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 48, height: 56)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(focusedField == index ? Color.activeBlue : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)), lineWidth: focusedField == index ? 2 : 1)
                                    )
                                    .focused($focusedField, equals: index)
                                }
                            }
                            .frame(maxWidth: .infinity)

                            Button(action: { dismiss() }) {
                                Text("इमेल बदल्नुहोस्")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.activeBlue)
                            }

                            NavigationLink(destination: PasswordSetupView()) {
                                Text("अगाडि बढ्नुहोस्")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 56)
                                    .background(Color.activeBlue)
                                    .cornerRadius(14)
                            }
                            .buttonStyle(.plain)
                            .disabled(!isOTPComplete)
                            .opacity(isOTPComplete ? 1.0 : 0.8)
                            
                            Button(action: {}) {
                                Text("OTP पुन पठाउनुहोस्")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.activeBlue)
                            }
                            .padding(.top, 8)
                        }
                        .frame(maxWidth: .infinity)
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
        .navigationTitle("इमेल OTP")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }

}

#Preview {
    NavigationView {
        EmailOTPView()
    }
}
