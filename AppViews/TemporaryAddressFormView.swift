import SwiftUI
import UIKit

struct TemporaryAddressFormView: View {
    @Binding var province: String
    @Binding var localBody: String
    @Binding var district: String
    @Binding var ward: String
    @Binding var tole: String

    @State private var showProvincePicker = false
    @State private var showDistrictPicker = false
    @Environment(\.colorScheme) private var colorScheme
    @FocusState private var focusedField: Field?

    private var isDarkMode: Bool { colorScheme == .dark }

    enum Field { case localBody, ward, tole }

    private let provinces = [
        "प्रदेश १", "प्रदेश २", "बागमती", "गण्डकी", "लुम्बिनी",
        "कर्णाली", "सुदूरपश्चिम"
    ]

    private let districts = [
        "काठमाडौं", "ललितपुर", "भक्तपुर", "काभ्रेपलाञ्चोक", "धादिङ",
        "नुवाकोट", "रसुवा", "सिन्धुपाल्चोक", "दोलखा", "रामेछाप",
        "सिन्धुली", "मकवानपुर", "चितवन", "पोखरा", "तनहुँ",
        "स्याङ्जा", "लमजुङ", "कास्की", "मनाङ", "मुस्ताङ"
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 10) {
                Image(systemName: "building.2.fill")
                    .font(.system(size: 18))
                    .foregroundColor(Color.activeBlue)
                Text("अस्थायी ठेगाना")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(isDarkMode ? .white.opacity(0.9) : .secondary)
            }

            addressField(
                label: "प्रदेश",
                value: province,
                placeholder: "प्रदेश छान्नुहोस्",
                isHighlighted: showProvincePicker,
                action: { showProvincePicker = true }
            )

            inputField(
                label: "स्थानिय निकाय (नगरपालिका/गाउँपालिका)",
                text: $localBody,
                field: .localBody
            )

            addressField(
                label: "जिल्ला",
                value: district,
                placeholder: "जिल्ला छान्नुहोस्",
                isHighlighted: showDistrictPicker,
                action: { showDistrictPicker = true }
            )

            inputField(label: "वडा नम्बर", text: $ward, field: .ward, keyboardType: .numberPad)

            inputField(label: "टोल / गली", text: $tole, field: .tole)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(isDarkMode ? Color.white.opacity(0.12) : Color(.tertiarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(isDarkMode ? Color.white.opacity(0.18) : Color(.separator), lineWidth: 1)
        )
        .sheet(isPresented: $showProvincePicker) {
            ProvincePickerView(selectedProvince: $province, provinces: provinces)
        }
        .sheet(isPresented: $showDistrictPicker) {
            DistrictPickerView(selectedDistrict: $district, districts: districts)
        }
    }

    private func addressField(
        label: String,
        value: String,
        placeholder: String,
        isHighlighted: Bool,
        action: @escaping () -> Void
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(isHighlighted ? Color.activeBlue : (isDarkMode ? .white.opacity(0.8) : .secondary))
            Button(action: action) {
                HStack {
                    Text(value.isEmpty ? placeholder : value)
                        .font(.body)
                        .foregroundColor(value.isEmpty ? (isDarkMode ? .white.opacity(0.5) : .secondary) : (isDarkMode ? .white : .primary))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: "chevron.down")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(isDarkMode ? .white.opacity(0.6) : .secondary)
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isHighlighted ? Color.activeBlue : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)), lineWidth: isHighlighted ? 2 : 1)
                )
            }
            .buttonStyle(.plain)
        }
    }

    private func inputField(label: String, text: Binding<String>, field: Field, keyboardType: UIKeyboardType = .default) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(focusedField == field ? Color.activeBlue : (isDarkMode ? .white.opacity(0.8) : .secondary))
            TextField("", text: text)
                .font(.body)
                .foregroundColor(isDarkMode ? .white : .primary)
                .keyboardType(keyboardType)
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(focusedField == field ? Color.activeBlue : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)), lineWidth: focusedField == field ? 2 : 1)
                )
                .focused($focusedField, equals: field)
        }
    }
}

// MARK: - Full-screen page (Permanent → this → Citizenship)
struct TemporaryAddressEntryPage: View {
    @State private var province = ""
    @State private var localBody = ""
    @State private var district = ""
    @State private var ward = ""
    @State private var tole = ""
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    private var isDarkMode: Bool { colorScheme == .dark }

    var body: some View {
        ZStack {
            FormBackgroundGradient()
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: 40)
                    VStack(spacing: 32) {
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.activeBlue.opacity(0.15))
                                    .frame(width: 80, height: 80)
                                Image(systemName: "building.2.fill")
                                    .font(.system(size: 36, weight: .semibold))
                                    .foregroundColor(Color.activeBlue)
                            }
                            VStack(spacing: 8) {
                                Text("अस्थायी ठेगाना")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(isDarkMode ? .white : .primary)
                                    .multilineTextAlignment(.center)
                                Text("आफ्नो अस्थायी ठेगानाको विवरण भर्नुहोस्")
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
                        VStack(alignment: .leading, spacing: 24) {
                            TemporaryAddressFormView(
                                province: $province,
                                localBody: $localBody,
                                district: $district,
                                ward: $ward,
                                tole: $tole
                            )
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
                                NavigationLink(destination: CitizenshipDetailEntryView()) {
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
        .navigationTitle("अस्थायी ठेगाना")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationView {
        TemporaryAddressEntryPage()
    }
}
