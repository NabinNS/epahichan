import SwiftUI

struct SignUpFormView: View {
    @State private var phoneNumber: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                VStack {
                    Spacer()

                    VStack(alignment: .leading, spacing: 24) {

                        Text("फोन नम्बर लेख्नुहोस्")
                            .font(.title2)
                            .fontWeight(.semibold)

                        TextField("98XXXXXXXX", text: $phoneNumber)
                            .keyboardType(.phonePad)
                            .font(.title3)
                            .padding(.horizontal, 16)
                            .frame(height: 50)
                            .background(Color(.secondarySystemBackground))
                            .overlay(
                                Rectangle()
                                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                            )

                        Text("फोन नम्बर छैन भने अगाडि बढ्नुहोस्")
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
                    .padding(.horizontal, 24)

                    Spacer()
                }
            }
            .navigationTitle("साइन अप")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SignUpFormView()
}
