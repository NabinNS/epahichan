import SwiftUI
import UIKit

enum ImagePickerSource {
    case camera(front: Bool)
    case photoLibrary
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    let source: ImagePickerSource
    var onDismiss: (() -> Void)?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = false
        
        switch source {
        case .camera(let front):
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                // Fallback to photo library if camera is not available
                picker.sourceType = .photoLibrary
                return picker
            }
            picker.sourceType = .camera
            picker.modalPresentationStyle = .fullScreen
            
            // Check if the requested camera device is available
            if front {
                if UIImagePickerController.isCameraDeviceAvailable(.front) {
                    picker.cameraDevice = .front
                } else if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                    picker.cameraDevice = .rear
                }
            } else {
                if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                    picker.cameraDevice = .rear
                } else if UIImagePickerController.isCameraDeviceAvailable(.front) {
                    picker.cameraDevice = .front
                }
            }
        case .photoLibrary:
            picker.sourceType = .photoLibrary
        }
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            picker.dismiss(animated: true) {
                self.parent.onDismiss?()
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true) {
                self.parent.onDismiss?()
            }
        }
    }
}

struct SelfieCaptureView: View {
    @State private var selfieImage: UIImage?
    @State private var showSourcePicker = false
    @State private var imagePickerSource: ImagePickerSourceWrapper?
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    
    private var isDarkMode: Bool { colorScheme == .dark }
    
    private var cameraAvailable: Bool { UIImagePickerController.isSourceTypeAvailable(.camera) }
    private var libraryAvailable: Bool { UIImagePickerController.isSourceTypeAvailable(.photoLibrary) }
    
    var body: some View {
        ZStack {
            FormBackgroundGradient()
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: 40)
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
                                    .foregroundColor(Color.activeBlue)
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
                                } else {
                                    VStack(spacing: 16) {
                                        Image(systemName: "camera.fill")
                                            .font(.system(size: 50))
                                            .foregroundColor(isDarkMode ? .white.opacity(0.5) : .secondary)
                                        
                                        Text("सेल्फी खिच्नुहोस्")
                                            .font(.body)
                                            .foregroundColor(isDarkMode ? .white.opacity(0.6) : .secondary)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 250)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(isDarkMode ? Color.white.opacity(0.2) : Color(.separator), lineWidth: 1)
                                    )
                                }
                                
                                Button(action: { showSourcePicker = true }) {
                                    HStack(spacing: 12) {
                                        Image(systemName: "camera.fill")
                                            .font(.system(size: 18))
                                        Text(selfieImage == nil ? "फोटो थप्नुहोस्" : "फोटो बदल्नुहोस्")
                                            .font(.body)
                                    }
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 56)
                                    .background(Color.activeBlue)
                                    .cornerRadius(14)
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
                        }
                        .padding(.horizontal, 24)
                        Spacer().frame(height: 40)
                    }
                }
            }
        }
        .navigationTitle("सेल्फी")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .confirmationDialog("फोटो थप्नुहोस्", isPresented: $showSourcePicker, titleVisibility: .visible) {
            if cameraAvailable {
                Button("क्यामेरा खोल्नुहोस्") {
                    showSourcePicker = false
                    imagePickerSource = ImagePickerSourceWrapper(source: .camera(front: true))
                }
            }
            if libraryAvailable {
                Button("ग्यालरी खोल्नुहोस्") {
                    showSourcePicker = false
                    imagePickerSource = ImagePickerSourceWrapper(source: .photoLibrary)
                }
            }
            Button("रद्द", role: .cancel) {
                showSourcePicker = false
            }
        } message: {
            Text("क्यामेरा खोल्नुहोस् वा ग्यालरी खोल्नुहोस्")
        }
        .sheet(item: $imagePickerSource) { wrapper in
            ImagePicker(image: $selfieImage, source: wrapper.source, onDismiss: {
                imagePickerSource = nil
            })
        }
    }
}

private struct ImagePickerSourceWrapper: Identifiable {
    let id = UUID()
    let source: ImagePickerSource
}

#Preview {
    NavigationView { SelfieCaptureView() }
}
