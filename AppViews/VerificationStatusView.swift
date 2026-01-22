import SwiftUI

struct VerificationStatusView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 24) {
                        
                        VStack(spacing: 16) {
                            Text("स्वागतम नबिन")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                            
                            Text("तपाईंको पहिचान प्रमाणीकरण को लागि पठाइएको छ")
                                .font(.body)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack(spacing: 12) {
                            Button(action: {
                            }) {
                                Text("स्थिति हेर्नुहोस्")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                            }
                            
                            Button(action: {
                            }) {
                                Text("थप ईस्थान मा पठाउनुहोस्")
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
            .navigationTitle("स्थिति")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    VerificationStatusView()
}
