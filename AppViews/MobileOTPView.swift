import SwiftUI

struct MobileOTPView: View {
    @State private var otpDigits: [String] = Array(repeating: "", count: 6)
    @FocusState private var focusedField: Int?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 24) {
                        
                        Text("तपाईंको फोनमा आएको ६ अंकको OTP लेख्नुहोस्")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        HStack(spacing: 12) {
                            ForEach(0..<6, id: \.self) { index in
                                TextField("", text: Binding(
                                    get: { otpDigits[index] },
                                    set: { newValue in
                                        if newValue.count <= 1 {
                                            otpDigits[index] = newValue
                                            if newValue.count == 1 && index < 5 {
                                                focusedField = index + 1
                                            }
                                        }
                                    }
                                ))
                                .keyboardType(.numberPad)
                                .font(.title)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .frame(width: 50, height: 50)
                                .background(Color(.secondarySystemBackground))
                                .overlay(
                                    Rectangle()
                                        .stroke(focusedField == index ? Color.blue : Color.blue.opacity(0.3), 
                                                lineWidth: focusedField == index ? 2 : 1)
                                )
                                .focused($focusedField, equals: index)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(alignment: .center)
                        
                        HStack {
                            Button(action: {
                            }) {
                                Text("फोन नम्बर बदल्नुहोस्")
                                    .font(.footnote)
                                    .foregroundColor(.blue)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                            }) {
                                Text("अगाडि बढ्नुहोस्")
                                    .font(.headline)
                                    .frame(height: 50)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 24)
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
            .navigationTitle("Mobile OTP")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MobileOTPView()
}
