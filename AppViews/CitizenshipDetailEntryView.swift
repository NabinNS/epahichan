import SwiftUI

struct CitizenshipDetailEntryView: View {
    @State private var citizenshipNumber: String = ""
    @State private var jariMiti: String = ""
    @State private var selectedDistrict: String = ""
    @State private var showDistrictPicker = false
    
    let districts = [
        "काठमाडौं",
        "ललितपुर",
        "भक्तपुर",
        "काभ्रेपलाञ्चोक",
        "धादिङ",
        "नुवाकोट",
        "रसुवा",
        "सिन्धुपाल्चोक",
        "दोलखा",
        "रामेछाप",
        "सिन्धुली",
        "मकवानपुर",
        "चितवन",
        "पोखरा",
        "तनहुँ",
        "स्याङ्जा",
        "लमजुङ",
        "कास्की",
        "मनाङ",
        "मुस्ताङ"
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 24) {
                        
                        Text("नागरिकता प्रविष्टि")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("नागरिकता नम्बर")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            TextField("", text: $citizenshipNumber)
                                .keyboardType(.numberPad)
                                .font(.title3)
                                .padding(.horizontal, 16)
                                .frame(height: 50)
                                .background(Color(.secondarySystemBackground))
                                .overlay(
                                    Rectangle()
                                        .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                )
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("जारी मिति")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            TextField("YYYY/MM/DD", text: $jariMiti)
                                .keyboardType(.numbersAndPunctuation)
                                .font(.title3)
                                .padding(.horizontal, 16)
                                .frame(height: 50)
                                .background(Color(.secondarySystemBackground))
                                .overlay(
                                    Rectangle()
                                        .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                )
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("जिल्ला")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            Button(action: {
                                showDistrictPicker = true
                            }) {
                                HStack {
                                    Text(selectedDistrict.isEmpty ? "जिल्ला छान्नुहोस्" : selectedDistrict)
                                        .font(.title3)
                                        .foregroundColor(selectedDistrict.isEmpty ? .secondary : .primary)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.secondary)
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
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("नागरिकता")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showDistrictPicker) {
                DistrictPickerView(selectedDistrict: $selectedDistrict, districts: districts)
            }
        }
    }
}

struct DistrictPickerView: View {
    @Binding var selectedDistrict: String
    let districts: [String]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                ForEach(districts, id: \.self) { district in
                    Button(action: {
                        selectedDistrict = district
                        dismiss()
                    }) {
                        HStack {
                            Text(district)
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            if selectedDistrict == district {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .navigationTitle("जिल्ला छान्नुहोस्")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("रद्द") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    CitizenshipDetailEntryView()
}
