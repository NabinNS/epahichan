import SwiftUI

struct FamilyDetailEntryView: View {
    @State private var fatherName: String = ""
    @State private var grandfatherName: String = ""
    @State private var spouseName: String = ""
    @State private var showConfirmation = false
    @State private var navigateToDashboard = false

    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?

    private var isDarkMode: Bool { colorScheme == .dark }

    enum Field { case fatherName, grandfatherName, spouseName }

    var body: some View {
        ZStack {
            FormBackgroundGradient()
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: 40)
                    VStack(spacing: 32) {
                        headerSection
                        formSection
                    }
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
        .navigationTitle("परिवार विवरण")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }

    private var headerSection: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.activeBlue.opacity(0.15))
                    .frame(width: 80, height: 80)
                Image(systemName: "person.2.fill")
                    .font(.system(size: 36, weight: .semibold))
                    .foregroundColor(Color.activeBlue)
            }
            VStack(spacing: 8) {
                Text("परिवार विवरण भर्नुहोस्")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(isDarkMode ? .white : .primary)
                    .multilineTextAlignment(.center)
                Text("बुबा, बाजे र पति/पत्नीको नाम भर्नुहोस्")
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
    }

    private var formSection: some View {
        VStack(alignment: .leading, spacing: 24) {
            inputRow(label: "बुबाको नाम", text: $fatherName, field: .fatherName)
            inputRow(label: "बाजेको नाम", text: $grandfatherName, field: .grandfatherName)
            inputRow(label: "पति/पत्नीको नाम", text: $spouseName, field: .spouseName)

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
                Button(action: { showConfirmation = true }) {
                    Text("पेश गर्नुहोस्")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.activeBlue)
                        .cornerRadius(14)
                }
            }
        }
        .padding(.horizontal, 24)
        .alert("पुष्टि गर्नुहोस्", isPresented: $showConfirmation) {
            Button("रद्द", role: .cancel) {}
            Button("पेश गर्नुहोस्") {
                navigateToDashboard = true
            }
        } message: {
            Text("के तपाईं यो विवरण पेश गर्न चाहनुहुन्छ?")
        }
        .background(
            NavigationLink(destination: DashboardView(), isActive: $navigateToDashboard) {
                EmptyView()
            }
        )
    }

    private func inputRow(label: String, text: Binding<String>, field: Field) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(label)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(isDarkMode ? .white.opacity(0.8) : .secondary)
            TextField("", text: text)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(isDarkMode ? .white : Color(.label))
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(focusedField == field
                              ? (isDarkMode ? Color.white.opacity(0.2) : Color(.systemGray5))
                              : (isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground)))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(focusedField == field
                                ? (isDarkMode ? Color.white.opacity(0.3) : Color(.systemGray3))
                                : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)),
                               lineWidth: focusedField == field ? 1.5 : 1)
                )
                .focused($focusedField, equals: field)
        }
    }
}

#Preview {
    NavigationView {
        FamilyDetailEntryView()
    }
}
