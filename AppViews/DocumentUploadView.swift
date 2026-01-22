import SwiftUI
import PhotosUI

struct DocumentUploadView: View {
    let documentType: String
    @State private var frontImage: UIImage?
    @State private var backImage: UIImage?
    @State private var singleImage: UIImage?
    @State private var frontPhotoPicker: PhotosPickerItem?
    @State private var backPhotoPicker: PhotosPickerItem?
    @State private var singlePhotoPicker: PhotosPickerItem?
    
    var isNagrita: Bool {
        documentType == "नागरिकता राष्ट्रिय परिचयपत्र"
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 24) {
                            
                            Text("\(documentType) को फोटो अपलोड गर्नुहोस्")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            if isNagrita {
                                VStack(spacing: 16) {
                                    Text("अगाडि (Front)")
                                        .font(.headline)
                                    
                                    if let frontImage = frontImage {
                                        Image(uiImage: frontImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 200)
                                            .background(Color(.secondarySystemBackground))
                                            .overlay(
                                                Rectangle()
                                                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                            )
                                    }
                                    
                                    PhotosPicker(selection: $frontPhotoPicker, matching: .images) {
                                        HStack {
                                            Image(systemName: "photo.badge.plus")
                                            Text(frontImage == nil ? "फोटो छान्नुहोस्" : "फोटो बदल्नुहोस्")
                                                .font(.body)
                                        }
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .foregroundColor(.blue)
                                        .background(Color(.secondarySystemBackground))
                                        .overlay(
                                            Rectangle()
                                                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                        )
                                    }
                                }
                                
                                VStack(spacing: 16) {
                                    Text("पछाडि (Back)")
                                        .font(.headline)
                                    
                                    if let backImage = backImage {
                                        Image(uiImage: backImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 200)
                                            .background(Color(.secondarySystemBackground))
                                            .overlay(
                                                Rectangle()
                                                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                            )
                                    }
                                    
                                    PhotosPicker(selection: $backPhotoPicker, matching: .images) {
                                        HStack {
                                            Image(systemName: "photo.badge.plus")
                                            Text(backImage == nil ? "फोटो छान्नुहोस्" : "फोटो बदल्नुहोस्")
                                                .font(.body)
                                        }
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .foregroundColor(.blue)
                                        .background(Color(.secondarySystemBackground))
                                        .overlay(
                                            Rectangle()
                                                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                        )
                                    }
                                }
                            } else {
                                VStack(spacing: 16) {
                                    if let singleImage = singleImage {
                                        Image(uiImage: singleImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 200)
                                            .background(Color(.secondarySystemBackground))
                                            .overlay(
                                                Rectangle()
                                                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                            )
                                    }
                                    
                                    PhotosPicker(selection: $singlePhotoPicker, matching: .images) {
                                        HStack {
                                            Image(systemName: "photo.badge.plus")
                                            Text(singleImage == nil ? "फोटो छान्नुहोस्" : "फोटो बदल्नुहोस्")
                                                .font(.body)
                                        }
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .foregroundColor(.blue)
                                        .background(Color(.secondarySystemBackground))
                                        .overlay(
                                            Rectangle()
                                                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                        )
                                    }
                                }
                            }
                            
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
                }
            }
            .navigationTitle("फोटो अपलोड")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: frontPhotoPicker) { oldValue, newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        frontImage = image
                    }
                }
            }
            .onChange(of: backPhotoPicker) { oldValue, newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        backImage = image
                    }
                }
            }
            .onChange(of: singlePhotoPicker) { oldValue, newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        singleImage = image
                    }
                }
            }
        }
    }
}

#Preview {
    DocumentUploadView(documentType: "नागरिकता राष्ट्रिय परिचयपत्र")
}
