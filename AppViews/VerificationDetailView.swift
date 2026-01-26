import SwiftUI
import UIKit

struct VerificationDetailView: View {
    var fullNameNepali: String = "राम बहादुर श्रेष्ठ"
    var fullNameEnglish: String = "Ram Bahadur Shrestha"
    var uploadedDocuments: [String] = ["नागरिकता राष्ट्रिय परिचयपत्र"]
    var selfieImage: UIImage?
    var verificationLocation: String = "काठमाडौं, केंद्रीय कार्यालय"

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
                                Image(systemName: "checkmark.shield.fill")
                                    .font(.system(size: 36, weight: .semibold))
                                    .foregroundColor(isDarkMode ? .cyan : Color.activeBlue)
                            }
                            VStack(spacing: 8) {
                                Text("विवरण समीक्षा गर्नुहोस्")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(isDarkMode ? .white : .primary)
                                    .multilineTextAlignment(.center)
                                Text("सबै विवरण सहि छ भने पठाउनुहोस्")
                                    .font(.subheadline)
                                    .foregroundColor(isDarkMode ? .white.opacity(0.7) : .secondary)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 8)
                            }
                        }
                        .padding(.top, 24)

                        VStack(alignment: .leading, spacing: 20) {
                            detailCard(title: "पूरा नाम") {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(fullNameNepali)
                                        .font(.body)
                                        .foregroundColor(isDarkMode ? .white : .primary)
                                    Text(fullNameEnglish)
                                        .font(.subheadline)
                                        .foregroundColor(isDarkMode ? .white.opacity(0.7) : .secondary)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }

                            detailCard(title: "अपलोड गरिएका कागजात") {
                                VStack(spacing: 10) {
                                    ForEach(uploadedDocuments, id: \.self) { doc in
                                        HStack(spacing: 12) {
                                            Image(systemName: "doc.fill")
                                                .font(.system(size: 18))
                                                .foregroundColor(isDarkMode ? .cyan : Color.activeBlue)
                                            Text(doc)
                                                .font(.body)
                                                .foregroundColor(isDarkMode ? .white : .primary)
                                            Spacer()
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(Color.activeBlue)
                                        }
                                        .padding(12)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(isDarkMode ? Color.white.opacity(0.08) : Color(.tertiarySystemBackground))
                                        )
                                    }
                                }
                            }

                            detailCard(title: "सेल्फी फोटो") {
                                if let img = selfieImage {
                                    Image(uiImage: img)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxHeight: 200)
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                } else {
                                    HStack(spacing: 12) {
                                        Image(systemName: "camera.fill")
                                            .font(.system(size: 24))
                                            .foregroundColor(isDarkMode ? .white.opacity(0.5) : .secondary)
                                        Text("सेल्फी अपलोड गरिएको छैन")
                                            .font(.body)
                                            .foregroundColor(isDarkMode ? .white.opacity(0.6) : .secondary)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 120)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(isDarkMode ? Color.white.opacity(0.08) : Color(.tertiarySystemBackground))
                                    )
                                }
                            }

                            detailCard(title: "प्रमाणीकरण ईस्थान") {
                                HStack(spacing: 12) {
                                    Image(systemName: "mappin.circle.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(isDarkMode ? .cyan : Color.activeBlue)
                                    Text(verificationLocation)
                                        .font(.body)
                                        .foregroundColor(isDarkMode ? .white : .primary)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }

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
                                NavigationLink(destination: DashboardView()) {
                                    Text("प्रमाणीकरण को लागि पठाउनुहोस्")
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
                        Spacer().frame(height: 40)
                    }
                }
            }
        }
        .navigationTitle("विवरण")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }

    private func detailCard<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(isDarkMode ? .white.opacity(0.9) : .secondary)
            content()
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isDarkMode ? Color.white.opacity(0.2) : Color(.separator), lineWidth: 1)
                )
        }
    }
}

#Preview {
    NavigationView {
        VerificationDetailView(
            fullNameNepali: "राम बहादुर श्रेष्ठ",
            fullNameEnglish: "Ram Bahadur Shrestha",
            uploadedDocuments: [
                "नागरिकता राष्ट्रिय परिचयपत्र",
                "चालक अनुमति पत्र"
            ],
            selfieImage: nil,
            verificationLocation: "काठमाडौं, केंद्रीय कार्यालय"
        )
    }
}
