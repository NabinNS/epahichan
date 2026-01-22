import SwiftUI

struct VerificationDetailView: View {
    let fullNameNepali: String
    let fullNameEnglish: String
    let uploadedDocuments: [String]
    let selfieImage: UIImage?
    let verificationLocation: String
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 24) {
                            
                            Text("विवरण समीक्षा गर्नुहोस्")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Text("पूरा नाम")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(fullNameNepali)
                                        .font(.body)
                                    
                                    Text(fullNameEnglish)
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(16)
                                .background(Color(.secondarySystemBackground))
                                .overlay(
                                    Rectangle()
                                        .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                )
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Text("अपलोड गरिएका कागजात")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                VStack(spacing: 8) {
                                    ForEach(uploadedDocuments, id: \.self) { document in
                                        HStack {
                                            Image(systemName: "doc.fill")
                                                .foregroundColor(.blue)
                                            Text(document)
                                                .font(.body)
                                            Spacer()
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(.green)
                                        }
                                        .padding(.horizontal, 16)
                                        .frame(height: 44)
                                        .background(Color(.secondarySystemBackground))
                                        .overlay(
                                            Rectangle()
                                                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                        )
                                    }
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Text("सेल्फी फोटो")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                if let selfieImage = selfieImage {
                                    Image(uiImage: selfieImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxHeight: 200)
                                        .background(Color(.secondarySystemBackground))
                                        .overlay(
                                            Rectangle()
                                                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                        )
                                } else {
                                    HStack {
                                        Image(systemName: "camera.fill")
                                            .foregroundColor(.secondary)
                                        Text("सेल्फी अपलोड गरिएको छैन")
                                            .font(.body)
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 100)
                                    .background(Color(.secondarySystemBackground))
                                    .overlay(
                                        Rectangle()
                                            .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                    )
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Text("प्रमाणीकरण ईस्थान")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                HStack {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.blue)
                                    Text(verificationLocation)
                                        .font(.body)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(16)
                                .background(Color(.secondarySystemBackground))
                                .overlay(
                                    Rectangle()
                                        .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                )
                            }
                            
                            HStack(spacing: 0) {
                                Button(action: {
                                }) {
                                    Text("फिर्ता जानुहोस्")
                                        .font(.headline)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .foregroundColor(.white)
                                        .background(Color.black)
                                }
                                
                                Button(action: {
                                }) {
                                    Text("प्रमाणीकरण को लागि पठाउनुहोस्")
                                        .font(.headline)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .foregroundColor(.white)
                                        .background(Color.blue)
                                }
                            }
                        }
                        .padding(24)
                        .background(Color.white)
                        .padding(.horizontal, 32)
                        
                        Spacer()
                    }
                }
            }
            .navigationTitle("विवरण")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
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
