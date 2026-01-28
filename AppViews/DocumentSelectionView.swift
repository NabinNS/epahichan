import SwiftUI

struct DocumentSelectionView: View {
    @State private var selectedDocument: String? = nil
    @Environment(\.colorScheme) private var colorScheme
    
    private var isDarkMode: Bool { colorScheme == .dark }
    
    let documents = [
        "नागरिकता राष्ट्रिय परिचयपत्र",
        "चालक अनुमति पत्र",
        "राहदानी",
        "अन्य कागजात हरू"
    ]
    
    var body: some View {
        ZStack {
            FormBackgroundGradient()
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: 20)
                    VStack(spacing: 32) {
                        VStack(spacing: 16) {
                            StepIndicatorView(current: 2, total: 5)
                                .padding(.horizontal, 24)
                            ZStack {
                                Circle()
                                    .fill(Color.activeBlue.opacity(0.15))
                                    .frame(width: 80, height: 80)
                                Image(systemName: "doc.text.fill")
                                    .font(.system(size: 36, weight: .semibold))
                                    .foregroundColor(isDarkMode ? .darkModeIcon : Color.activeBlue)
                            }
                            VStack(spacing: 8) {
                                Text("कागज छान्नुहोस्")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(isDarkMode ? .white : .primary)
                                    .multilineTextAlignment(.center)
                                Text("प्रमाणीकरण को लागि प्रस्तुत गर्ने कागज छान्नुहोस्")
                                    .font(.subheadline)
                                    .foregroundColor(isDarkMode ? .white.opacity(0.7) : .secondary)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 8)
                            }
                        }
                        .padding(.top, 24)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(spacing: 12) {
                                ForEach(documents, id: \.self) { document in
                                    Button(action: {
                                        if selectedDocument == document {
                                            selectedDocument = nil
                                        } else {
                                            selectedDocument = document
                                        }
                                    }) {
                                        HStack(spacing: 16) {
                                            Image(systemName: selectedDocument == document ? "checkmark.circle.fill" : "circle")
                                                .font(.system(size: 22))
                                                .foregroundColor(selectedDocument == document ? (isDarkMode ? .darkModeIcon : Color.activeBlue) : (isDarkMode ? .white.opacity(0.4) : .secondary))
                                            
                                            Text(document)
                                                .font(.body)
                                                .foregroundColor(isDarkMode ? .white : .primary)
                                            
                                            Spacer()
                                        }
                                        .padding(16)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(selectedDocument == document ? Color.activeBlue : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)), lineWidth: selectedDocument == document ? 2 : 1)
                                        )
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            
                            NavigationLink(destination: DocumentUploadView(documentType: selectedDocument ?? documents[0])) {
                                Text("अगाडि बढ्नुहोस्")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 56)
                                    .background(Color.activeBlue)
                                    .cornerRadius(14)
                            }
                            .buttonStyle(.plain)
                            .disabled(selectedDocument == nil)
                            .opacity(selectedDocument == nil ? 0.6 : 1.0)
                        }
                        .padding(.horizontal, 24)
                        Spacer().frame(height: 40)
                    }
                }
            }
        }
        .navigationTitle("कागज छान्नुहोस्")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView { DocumentSelectionView() }
}
