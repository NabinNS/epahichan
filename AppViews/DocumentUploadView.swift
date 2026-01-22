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
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    
    private var isDarkMode: Bool { colorScheme == .dark }
    
    var isNagrita: Bool {
        documentType == "नागरिकता राष्ट्रिय परिचयपत्र"
    }
    
    var body: some View {
        ZStack {
            FormBackgroundGradient()
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: 40)
                    VStack(spacing: 32) {
                        VStack(spacing: 16) {
                            StepIndicatorView(current: 3, total: 4)
                                .padding(.horizontal, 24)
                            ZStack {
                                Circle()
                                    .fill(Color.activeBlue.opacity(0.15))
                                    .frame(width: 80, height: 80)
                                Image(systemName: "photo.badge.plus")
                                    .font(.system(size: 36, weight: .semibold))
                                    .foregroundColor(Color.activeBlue)
                            }
                            VStack(spacing: 8) {
                                Text("कागजात अपलोड")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(isDarkMode ? .white : .primary)
                                    .multilineTextAlignment(.center)
                                Text("\(documentType) को फोटो अपलोड गर्नुहोस्")
                                    .font(.subheadline)
                                    .foregroundColor(isDarkMode ? .white.opacity(0.7) : .secondary)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 8)
                            }
                        }
                        .padding(.top, 24)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            if isNagrita {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("अगाडि (Front)")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(isDarkMode ? .white.opacity(0.9) : .secondary)
                                    
                                    if let frontImage = frontImage {
                                        Image(uiImage: frontImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(height: 200)
                                            .clipped()
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    }
                                    
                                    PhotosPicker(selection: $frontPhotoPicker, matching: .images) {
                                        HStack(spacing: 12) {
                                            Image(systemName: "photo.badge.plus")
                                                .font(.system(size: 18))
                                            Text(frontImage == nil ? "फोटो छान्नुहोस्" : "फोटो बदल्नुहोस्")
                                                .font(.body)
                                        }
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 56)
                                        .background(Color.activeBlue)
                                        .cornerRadius(14)
                                    }
                                }
                                
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("पछाडि (Back)")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(isDarkMode ? .white.opacity(0.9) : .secondary)
                                    
                                    if let backImage = backImage {
                                        Image(uiImage: backImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(height: 200)
                                            .clipped()
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    }
                                    
                                    PhotosPicker(selection: $backPhotoPicker, matching: .images) {
                                        HStack(spacing: 12) {
                                            Image(systemName: "photo.badge.plus")
                                                .font(.system(size: 18))
                                            Text(backImage == nil ? "फोटो छान्नुहोस्" : "फोटो बदल्नुहोस्")
                                                .font(.body)
                                        }
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 56)
                                        .background(Color.activeBlue)
                                        .cornerRadius(14)
                                    }
                                }
                            } else {
                                VStack(alignment: .leading, spacing: 12) {
                                    if let singleImage = singleImage {
                                        Image(uiImage: singleImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(height: 200)
                                            .clipped()
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    }
                                    
                                    PhotosPicker(selection: $singlePhotoPicker, matching: .images) {
                                        HStack(spacing: 12) {
                                            Image(systemName: "photo.badge.plus")
                                                .font(.system(size: 18))
                                            Text(singleImage == nil ? "फोटो छान्नुहोस्" : "फोटो बदल्नुहोस्")
                                                .font(.body)
                                        }
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 56)
                                        .background(Color.activeBlue)
                                        .cornerRadius(14)
                                    }
                                }
                            }
                            
                            HStack(spacing: 12) {
                                Button(action: { dismiss() }) {
                                    HStack(spacing: 8) {
                                        Image(systemName: "chevron.left")
                                            .font(.system(size: 16, weight: .semibold))
                                        Text("पछाडि जानुहोस्")
                                            .font(.system(size: 18, weight: .semibold))
                                    }
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 56)
                                    .background(isDarkMode ? Color.white.opacity(0.25) : Color(.systemGray))
                                    .cornerRadius(14)
                                }
                                .buttonStyle(.plain)
                                
                                NavigationLink(destination: SelfieCaptureView()) {
                                    Text("अगाडि बढ्नुहोस्")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 56)
                                        .background(Color.activeBlue)
                                        .cornerRadius(14)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 24)
                        Spacer().frame(height: 40)
                    }
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

#Preview {
    NavigationView {
        DocumentUploadView(documentType: "नागरिकता राष्ट्रिय परिचयपत्र")
    }
}
