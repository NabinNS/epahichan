import SwiftUI

struct DocumentSelectionView: View {
    @State private var selectedDocuments: Set<String> = []
    
    let documents = [
        "नागरिकता राष्ट्रिय परिचयपत्र",
        "चालक अनुमति पत्र",
        "राहदानी",
        "अन्य कागजात हरू"
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 24) {
                        
                        Text("प्रमाणीकरण को लागि प्रस्तुत गर्ने कागज छान्नुहोस्")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 12) {
                            ForEach(documents, id: \.self) { document in
                                Button(action: {
                                    if selectedDocuments.contains(document) {
                                        selectedDocuments.remove(document)
                                    } else {
                                        selectedDocuments.insert(document)
                                    }
                                }) {
                                    HStack {
                                        Text(document)
                                            .font(.body)
                                            .foregroundColor(.primary)
                                        
                                        Spacer()
                                        
                                        Image(systemName: selectedDocuments.contains(document) ? "checkmark.square.fill" : "square")
                                            .foregroundColor(selectedDocuments.contains(document) ? .blue : .gray)
                                    }
                                    .padding(.horizontal, 16)
                                    .frame(height: 50)
                                    .background(Color(.secondarySystemBackground))
                                    .overlay(
                                        Rectangle()
                                            .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                    )
                                }
                            }
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
                                Text("अगाडि बढ्नुहोस्")
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
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("कागज छान्नुहोस्")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    DocumentSelectionView()
}
