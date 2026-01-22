import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 24) {
                        
                        VStack(spacing: 16) {
                            Image(systemName: "app.fill")
                                .font(.system(size: 80))
                                .foregroundColor(.blue)
                            
                            Text("Epahichan मा स्वागत छ")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                            
                            Text("तपाईं प्रमाणित हुनु वाएको छैन")
                                .font(.body)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                        }
                        .frame(maxWidth: .infinity)
                        
                        Button(action: {
                        }) {
                            Text("प्रमाणित गर्नुहोस्")
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
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    DashboardView()
}
