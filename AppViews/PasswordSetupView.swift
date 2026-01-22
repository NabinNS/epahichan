import SwiftUI

struct PasswordSetupView: View {
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 24) {
                        
                        Text("पासवर्ड राख्नुहोस्")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        SecureField("पासवर्ड", text: $password)
                            .font(.title3)
                            .padding(.horizontal, 16)
                            .frame(height: 50)
                            .background(Color(.secondarySystemBackground))
                            .overlay(
                                Rectangle()
                                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                            )
                        
                        Text("पासवर्ड पुन लेख्नुहोस्")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        SecureField("पासवर्ड पुन", text: $confirmPassword)
                            .font(.title3)
                            .padding(.horizontal, 16)
                            .frame(height: 50)
                            .background(Color(.secondarySystemBackground))
                            .overlay(
                                Rectangle()
                                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                            )
                        
                        Button(action: {
                        }) {
                            Text("अहिले हैन")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                        
                        Button(action: {
                        }) {
                            Text("सुरक्षित गर्नुहोस्")
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
            .navigationTitle("पासवर्ड")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    PasswordSetupView()
}
