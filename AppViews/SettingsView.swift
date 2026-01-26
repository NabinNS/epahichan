import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("isDarkMode") private var isDarkModeEnabled = false
    
    private var isDarkMode: Bool { colorScheme == .dark }
    
    var body: some View {
        ZStack {
            FormBackgroundGradient()
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: 40)
                    
                    VStack(spacing: 32) {
                        // Profile Header
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.activeBlue.opacity(0.15))
                                    .frame(width: 100, height: 100)
                                
                                Image(systemName: "person.circle.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(Color.activeBlue)
                            }
                            
                            VStack(spacing: 4) {
                                Text("नबिन श्रेष्ठ")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(isDarkMode ? .white : .primary)
                                
                                Text("+977 9841234567")
                                    .font(.subheadline)
                                    .foregroundColor(isDarkMode ? .white.opacity(0.7) : .secondary)
                            }
                        }
                        .padding(.top, 24)
                        
                        // Settings List
                        VStack(spacing: 16) {
                            // Dark Mode Toggle
                            settingsRow(
                                icon: isDarkModeEnabled ? "moon.fill" : "sun.max.fill",
                                title: "डार्क मोड",
                                subtitle: isDarkModeEnabled ? "डार्क मोड सक्षम" : "लाइट मोड सक्षम",
                                toggle: $isDarkModeEnabled
                            )
                            
                            // Language
                            NavigationLink(destination: Text("भाषा सेटिङ")) {
                                settingsRow(
                                    icon: "globe",
                                    title: "भाषा",
                                    subtitle: "नेपाली",
                                    showChevron: true
                                )
                            }
                            .buttonStyle(.plain)
                            
                            // Privacy
                            NavigationLink(destination: Text("गोपनीयता")) {
                                settingsRow(
                                    icon: "lock.fill",
                                    title: "गोपनीयता",
                                    subtitle: "गोपनीयता सेटिङहरू",
                                    showChevron: true
                                )
                            }
                            .buttonStyle(.plain)
                            
                            // About
                            NavigationLink(destination: Text("बारेमा")) {
                                settingsRow(
                                    icon: "info.circle.fill",
                                    title: "बारेमा",
                                    subtitle: "अप्पको बारेमा",
                                    showChevron: true
                                )
                            }
                            .buttonStyle(.plain)
                            
                            // Help & Support
                            NavigationLink(destination: Text("सहयोग")) {
                                settingsRow(
                                    icon: "questionmark.circle.fill",
                                    title: "सहयोग",
                                    subtitle: "मद्दत र समर्थन",
                                    showChevron: true
                                )
                            }
                            .buttonStyle(.plain)
                            
                            // Logout
                            Button(action: {}) {
                                settingsRow(
                                    icon: "arrow.right.square.fill",
                                    title: "लगआउट",
                                    subtitle: "खाताबाट बाहिर निस्कनुहोस्",
                                    showChevron: false,
                                    isDestructive: true
                                )
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.horizontal, 24)
                        
                        Spacer().frame(height: 40)
                    }
                }
            }
        }
    }
    
    private func settingsRow(
        icon: String,
        title: String,
        subtitle: String,
        toggle: Binding<Bool>? = nil,
        showChevron: Bool = false,
        isDestructive: Bool = false
    ) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(isDestructive ? .red : Color.activeBlue)
                .frame(width: 32, height: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(isDestructive ? .red : (isDarkMode ? .white : .primary))
                
                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(isDarkMode ? .white.opacity(0.6) : .secondary)
            }
            
            Spacer()
            
            if let toggle = toggle {
                Toggle("", isOn: toggle)
                    .labelsHidden()
            } else if showChevron {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(isDarkMode ? .white.opacity(0.4) : .secondary)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isDarkMode ? Color.white.opacity(0.2) : Color(.separator), lineWidth: 1)
        )
    }
}

#Preview {
    NavigationView {
        SettingsView()
    }
}
