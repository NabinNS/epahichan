import SwiftUI
import UIKit

enum DocumentPhotoSlot {
    case front, back, single
}

private struct DocumentPickerContext: Identifiable {
    let id = UUID()
    let slot: DocumentPhotoSlot
    let source: ImagePickerSource
}

struct DocumentUploadView: View {
    let documentType: String
    @State private var frontImage: UIImage?
    @State private var backImage: UIImage?
    @State private var singleImage: UIImage?
    @State private var pendingSlot: DocumentPhotoSlot?
    @State private var pickerContext: DocumentPickerContext?
    @State private var temporaryImage: UIImage?
    @Environment(\.colorScheme) private var colorScheme

    private var isDarkMode: Bool { colorScheme == .dark }
    private var cameraAvailable: Bool { UIImagePickerController.isSourceTypeAvailable(.camera) }
    private var libraryAvailable: Bool { UIImagePickerController.isSourceTypeAvailable(.photoLibrary) }

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
                            StepIndicatorView(current: 3, total: 5)
                                .padding(.horizontal, 24)
                            ZStack {
                                Circle()
                                    .fill(Color.activeBlue.opacity(0.15))
                                    .frame(width: 80, height: 80)
                                Image(systemName: "photo.badge.plus")
                                    .font(.system(size: 36, weight: .semibold))
                                    .foregroundColor(isDarkMode ? .darkModeIcon : Color.activeBlue)
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
                                documentPhotoSection(
                                    title: "अगाडि (Front)",
                                    image: frontImage,
                                    onAdd: { pendingSlot = .front }
                                )
                                documentPhotoSection(
                                    title: "पछाडि (Back)",
                                    image: backImage,
                                    onAdd: { pendingSlot = .back }
                                )
                            } else {
                                documentPhotoSection(
                                    title: nil,
                                    image: singleImage,
                                    onAdd: { pendingSlot = .single }
                                )
                            }

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
                        .padding(.horizontal, 24)
                        Spacer().frame(height: 40)
                    }
                }
            }
        }
        .navigationTitle("फोटो अपलोड")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: Binding(
            get: { pendingSlot != nil },
            set: { if !$0 { pendingSlot = nil } }
        )) {
            PhotoSourcePickerSheet(
                isPresented: Binding(
                    get: { pendingSlot != nil },
                    set: { if !$0 { pendingSlot = nil } }
                ),
                cameraAvailable: cameraAvailable,
                libraryAvailable: libraryAvailable,
                onCameraSelected: {
                    if let slot = pendingSlot {
                        pickerContext = DocumentPickerContext(slot: slot, source: .camera(front: false))
                        pendingSlot = nil
                    }
                },
                onLibrarySelected: {
                    if let slot = pendingSlot {
                        pickerContext = DocumentPickerContext(slot: slot, source: .photoLibrary)
                        pendingSlot = nil
                    }
                }
            )
        }
        .sheet(item: $pickerContext) { ctx in
            ImagePicker(image: $temporaryImage, source: ctx.source, onDismiss: {
                let slot = ctx.slot
                if let img = self.temporaryImage {
                    switch slot {
                    case .front: self.frontImage = img
                    case .back: self.backImage = img
                    case .single: self.singleImage = img
                    }
                }
                self.temporaryImage = nil
                self.pickerContext = nil
            })
        }
    }

    @ViewBuilder
    private func documentPhotoSection(title: String?, image: UIImage?, onAdd: @escaping () -> Void) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            if let title = title {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(isDarkMode ? .white.opacity(0.9) : .secondary)
            }
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Button(action: onAdd) {
                HStack(spacing: 12) {
                    Image(systemName: "photo.badge.plus")
                        .font(.system(size: 18))
                    Text(image == nil ? "फोटो थप्नुहोस्" : "फोटो बदल्नुहोस्")
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
}

#Preview {
    NavigationView {
        DocumentUploadView(documentType: "नागरिकता राष्ट्रिय परिचयपत्र")
    }
}
