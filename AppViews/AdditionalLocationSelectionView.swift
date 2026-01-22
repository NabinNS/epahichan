import SwiftUI

struct AdditionalLocationSelectionView: View {
    @State private var searchText: String = ""
    @State private var selectedLocations: [String] = []
    
    let allLocations = [
        "काठमाडौं, केंद्रीय कार्यालय",
        "ललितपुर, कार्यालय",
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
        let availableLocations = allLocations.filter { !selectedLocations.contains($0) }
        if searchText.isEmpty {
            return availableLocations
        } else {
            return availableLocations.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        
                        VStack(alignment: .leading, spacing: 24) {
                            
                            Text("प्रमाणीकरण ईस्थान")
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
                        }
                        .padding(24)
                        .background(Color.white)
                        .padding(.horizontal, 32)
                        .padding(.top)
                        
                        if !filteredLocations.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                ScrollView {
                                    VStack(spacing: 12) {
                                        ForEach(filteredLocations, id: \.self) { location in
                                            Button(action: {
                                                if !selectedLocations.contains(location) {
                                                    selectedLocations.append(location)
                                                    searchText = ""
                                                }
                                            }) {
                                                HStack {
                                                    Text(location)
                                                        .font(.body)
                                                        .foregroundColor(.primary)
                                                    
                                                    Spacer()
                                                    
                                                    Image(systemName: "plus.circle")
                                                        .foregroundColor(.blue)
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
                                }
                                .frame(maxHeight: 300)
                            }
                            .padding(24)
                            .background(Color.white)
                            .padding(.horizontal, 32)
                        }
                        
                        VStack(alignment: .leading, spacing: 24) {
                            if !selectedLocations.isEmpty {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("प्रमाणीकरण को लागि पठाएको ईस्थान हरू")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                    
                                    ScrollView {
                                        VStack(spacing: 8) {
                                            ForEach(selectedLocations, id: \.self) { location in
                                                HStack {
                                                    Text(location)
                                                        .font(.body)
                                                        .foregroundColor(.primary)
                                                    
                                                    Spacer()
                                                    
                                                    Button(action: {
                                                        selectedLocations.removeAll { $0 == location }
                                                    }) {
                                                        Text("हटाउनुहोस्")
                                                            .font(.footnote)
                                                            .foregroundColor(.red)
                                                            .padding(.horizontal, 12)
                                                            .padding(.vertical, 6)
                                                            .background(Color.red.opacity(0.1))
                                                            .overlay(
                                                                Rectangle()
                                                                    .stroke(Color.red.opacity(0.3), lineWidth: 1)
                                                            )
                                                    }
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
                                    .frame(maxHeight: 200)
                                }
                            }
                            
                            HStack(spacing: 0) {
                                Button(action: {
                                }) {
                                    Text("पछाडि जानुहोस्")
                                        .font(.headline)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .foregroundColor(.white)
                                        .background(Color.black)
                                }
                                
                                Button(action: {
                                }) {
                                    Text("पेश गर्नुहोस्")
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
                        .padding(.bottom)
                    }
                }
            }
            .navigationTitle("ईस्थान थप्नुहोस्")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AdditionalLocationSelectionView()
}
