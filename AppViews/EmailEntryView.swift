import SwiftUI

struct EmailEntryView: View {
    @State private var email: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 24) {
                        
                        Text("Email लेख्नुहोस्")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        TextField("", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .font(.title3)
                            .padding(.horizontal, 16)
                            .frame(height: 50)
                            .background(Color(.secondarySystemBackground))
                            .overlay(
                                Rectangle()
                                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                            )
                        
                        Text("फोन नम्बर बाट जारी राख्नुहोस्")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
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
                    .padding(24)
                    .background(Color.white)
                    .padding(.horizontal, 32)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Email")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    EmailEntryView()
}
