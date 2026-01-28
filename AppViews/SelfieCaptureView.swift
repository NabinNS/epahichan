import SwiftUI
import UIKit

struct SelfieCaptureView: View {
    @State private var selfieImage: UIImage?
    @State private var showSourcePicker = false
    @State private var imagePickerSource: ImagePickerSourceWrapper?
    @Environment(\.colorScheme) private var colorScheme
    
    private var isDarkMode: Bool { colorScheme == .dark }
    
    private var cameraAvailable: Bool { UIImagePickerController.isSourceTypeAvailable(.camera) }
    private var libraryAvailable: Bool { UIImagePickerController.isSourceTypeAvailable(.photoLibrary) }
    
    var body: some View {
        ZStack {
            FormBackgroundGradient()
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: 20)
                    VStack(spacing: 32) {
                        VStack(spacing: 16) {
                            StepIndicatorView(current: 4, total: 5)
                                .padding(.horizontal, 24)
                            ZStack {
                                Circle()
                                    .fill(Color.activeBlue.opacity(0.15))
                                    .frame(width: 80, height: 80)
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 36, weight: .semibold))
                                    .foregroundColor(isDarkMode ? .darkModeIcon : Color.activeBlue)
                            }
                            VStack(spacing: 8) {
                                Text("सेल्फी फोटो")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(isDarkMode ? .white : .primary)
                                    .multilineTextAlignment(.center)
                                Text("कागजात संग आफ्नो अनुहार आउने गरी फोटो खिच्नुहोस्")
                                    .font(.subheadline)
                                    .foregroundColor(isDarkMode ? .white.opacity(0.7) : .secondary)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 8)
                            }
                        }
                        .padding(.top, 24)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 12) {
                                if let selfieImage = selfieImage {
                                    Image(uiImage: selfieImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 300)
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .overlay(
                                            Button(action: { showSourcePicker = true }) {
                                                Image(systemName: "camera.fill")
                                                    .font(.system(size: 24))
                                                    .foregroundColor(.white)
                                                    .frame(width: 50, height: 50)
                                                    .background(Color.black.opacity(0.5))
                                                    .clipShape(Circle())
                                            }
                                            .buttonStyle(.plain)
                                            .padding(12),
                                            alignment: .topTrailing
                                        )
                                } else {
                                    Button(action: { showSourcePicker = true }) {
                                        VStack(spacing: 16) {
                                            Image(systemName: "camera.fill")
                                                .font(.system(size: 50))
                                                .foregroundColor(isDarkMode ? .white.opacity(0.5) : .secondary)
                                            
                                            Text("सेल्फी खिच्नुहोस्")
                                                .font(.body)
                                                .foregroundColor(isDarkMode ? .white.opacity(0.6) : .secondary)
                                        }
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 200)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(isDarkMode ? Color.white.opacity(0.2) : Color(.separator), lineWidth: 1)
                                        )
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            
                            NavigationLink(destination: LocationSelectionView()) {
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
                        .padding(.horizontal, 24)
                        Spacer().frame(height: 40)
                    }
                }
            }
        }
        .navigationTitle("सेल्फी")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showSourcePicker) {
            PhotoSourcePickerSheet(
                isPresented: $showSourcePicker,
                cameraAvailable: cameraAvailable,
                libraryAvailable: libraryAvailable,
                onCameraSelected: {
                    imagePickerSource = ImagePickerSourceWrapper(source: .camera(front: true))
                },
                onLibrarySelected: {
                    imagePickerSource = ImagePickerSourceWrapper(source: .photoLibrary)
                }
            )
        }
        .sheet(item: $imagePickerSource) { wrapper in
            ImagePicker(image: $selfieImage, source: wrapper.source, onDismiss: {
                imagePickerSource = nil
            })
        }
    }
}

#Preview {
    NavigationView { SelfieCaptureView() }
}
