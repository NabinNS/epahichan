import SwiftUI

struct PersonalDetailView: View {
    // Placeholder data – replace with real bindings/models
    let personalInfo: [String: String] = [
        "पूरा नाम": "राम बहादुर श्रेष्ठ",
        "जन्म मिति": "२०४५/०१/१२",
        "मोबाइल": "९८००००००००",
        "इमेल": "ram@example.com"
    ]

    let permanentAddress: [String: String] = [
        "प्रदेश": "बाग्मती",
        "जिल्ला": "काठमाडौं",
        "पालिका": "काठमाण्डौ महानगरपालिका",
        "वडा": "१०"
    ]

    let temporaryAddress: [String: String] = [
        "प्रदेश": "बाग्मती",
        "जिल्ला": "ललितपुर",
        "पालिका": "ललितपुर महानगरपालिका",
        "वडा": "३"
    ]

    let ancestryInfo: [String: String] = [
        "बाबुको नाम": "कृष्ण बहादुर श्रेष्ठ",
        "हजुरबाबुको नाम": "हरि बहादुर श्रेष्ठ",
        "हजुरहजुरबाबुको नाम": "गोपी बहादुर श्रेष्ठ"
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    detailCard(title: "व्यक्तिगत विवरण", data: personalInfo)
                    detailCard(title: "स्थायी ठेगाना", data: permanentAddress)
                    detailCard(title: "अस्थायी ठेगाना", data: temporaryAddress)
                    detailCard(title: "तीन पुस्ते विवरण", data: ancestryInfo)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .navigationTitle("ब्यक्तिगत विवरण")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    @ViewBuilder
    private func detailCard(title: String, data: [String: String]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)

            VStack(spacing: 8) {
                ForEach(data.sorted(by: { $0.key < $1.key }), id: \.key) { item in
                    HStack {
                        Text(item.key)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(item.value)
                            .font(.body)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .overlay(
            Rectangle()
                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
        )
    }
}

#Preview {
    PersonalDetailView()
}
