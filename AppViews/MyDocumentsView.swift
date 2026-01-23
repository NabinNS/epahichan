import SwiftUI

struct MyDocumentsView: View {
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    VStack(alignment: .leading, spacing: 24) {
                        HStack(spacing: 12) {
                            Image(systemName: "doc.text.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                            
                            Text("मेरो कागज")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                    }
                    .padding(24)
                    .background(Color.white)
                    .padding(.horizontal, 32)
                    .padding(.top)
                    
                    VStack(spacing: 12) {
                        NavigationLink(destination: PersonalDetailView()) {
                            DocumentCard(
                                title: "व्यक्तिगत विवरण",
                                icon: "person.fill"
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: EmptyView()) {
                            DocumentCard(
                                title: "कागजात",
                                icon: "doc.fill"
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: EmptyView()) {
                            DocumentCard(
                                title: "प्रमाण गरिएको कागज",
                                icon: "checkmark.shield.fill"
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: EmptyView()) {
                            DocumentCard(
                                title: "प्रमाणपत्र",
                                icon: "certificate.fill"
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 32)
                    
                    Button(action: {
                    }) {
                        Text("पछाडि जानुहोस्")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .background(Color.black)
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom)
                }
            }
        }
        .navigationTitle("मेरो कागज")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

struct DocumentCard: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 40, height: 40)
            
            Text(title)
                .font(.body)
                .foregroundColor(.primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .font(.caption)
        }
        .padding(16)
        .background(Color.white)
        .overlay(
            Rectangle()
                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
        )
    }
}

#Preview {
    MyDocumentsView()
}
