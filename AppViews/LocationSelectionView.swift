import SwiftUI

struct LocationSelectionView: View {
    @State private var searchText: String = ""
    @State private var selectedLocation: String?
    
    let locations = [
        "काठमाडौं, केंद्रीय कार्यालय",
        "ललितपुर, कार्यालय",
        "भक्तपुर, कार्यालय",
        "पोखरा, कार्यालय",
        "चितवन, कार्यालय",
        "बिराटनगर, कार्यालय",
        "धरान, कार्यालय",
        "बुटवल, कार्यालय",
        "हेटौडा, कार्यालय",
        "नारायणगढ, कार्यालय",
        "भक्तपुर, कार्यालय",
        "पोखरा, कार्यालय",
        "चितवन, कार्यालय",
        "बिराटनगर, कार्यालय",
        "धरान, कार्यालय",
        "बुटवल, कार्यालय",
        "हेटौडा, कार्यालय",
        "नारायणगढ, कार्यालय"
    ]
    
    var filteredLocations: [String] {
        if searchText.isEmpty {
            return locations
        } else {
            return locations.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 24) {
                        
                        Text("प्रमाणीकरण ईस्थान छान्नुहोस्")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.secondary)
                            
                            TextField("स्थान खोज्नुहोस्", text: $searchText)
                                .font(.body)
                        }
                        .padding(.horizontal, 16)
                        .frame(height: 50)
                        .background(Color(.secondarySystemBackground))
                        .overlay(
                            Rectangle()
                                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                        )
                        
                        ScrollView {
                            VStack(spacing: 12) {
                                ForEach(filteredLocations, id: \.self) { location in
                                    Button(action: {
                                        selectedLocation = location
                                    }) {
                                        HStack {
                                            Text(location)
                                                .font(.body)
                                                .foregroundColor(.primary)
                                            
                                            Spacer()
                                            
                                            Image(systemName: selectedLocation == location ? "checkmark.circle.fill" : "circle")
                                                .foregroundColor(selectedLocation == location ? .blue : .gray)
                                        }
                                        .padding(.horizontal, 16)
                                        .frame(height: 50)
                                        .background(Color(.secondarySystemBackground))
                                        .overlay(
                                            Rectangle()
                                                .stroke(selectedLocation == location ? Color.blue : Color.blue.opacity(0.3), lineWidth: selectedLocation == location ? 2 : 1)
                                        )
                                    }
                                }
                            }
                        }
                        .frame(maxHeight: 300)
                        
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
            .navigationTitle("स्थान छान्नुहोस्")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    LocationSelectionView()
}
