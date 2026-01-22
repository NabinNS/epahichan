import SwiftUI

struct NameEntryView: View {
    @State private var nepaliName: String = ""
    @State private var englishName: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 24) {
                        
                        Text("पूरा नाम नेपाली मा लेख्नुहोस्")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        TextField("", text: $nepaliName)
                            .font(.title3)
                            .padding(.horizontal, 16)
                            .frame(height: 50)
                            .background(Color(.secondarySystemBackground))
                            .overlay(
                                Rectangle()
                                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                            )
                        
                        Text("पूरा नाम English मा लेख्नुहोस्")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        TextField("", text: $englishName)
                            .font(.title3)
                            .padding(.horizontal, 16)
                            .frame(height: 50)
                            .background(Color(.secondarySystemBackground))
                            .overlay(
                                Rectangle()
                                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                            )
                        
                        HStack(spacing: 0) {
                            Button(action: {
                            }) {
                                Text("रद्द गर्नुहोस्")
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
            .navigationTitle("नाम")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NameEntryView()
}
