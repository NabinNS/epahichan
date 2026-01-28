import SwiftUI

struct DashboardView: View {
    @State private var showNotifications = false
    @State private var selectedTab = 0
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("isDarkMode") private var isDarkModeEnabled = false
    
    private var isDarkMode: Bool { colorScheme == .dark }
    
    // Sample progress data - in real app, this would come from a data model
    @State private var progressSteps: [ProgressStep] = [
        ProgressStep(id: 1, title: "नाम प्रविष्टि", isCompleted: true, date: "२०८०/१२/१५"),
        ProgressStep(id: 2, title: "कागजात अपलोड", isCompleted: true, date: "२०८०/१२/१६"),
        ProgressStep(id: 3, title: "सेल्फी फोटो", isCompleted: true, date: "२०८०/१२/१६"),
        ProgressStep(id: 4, title: "नागरिकता विवरण", isCompleted: false, date: nil),
        ProgressStep(id: 5, title: "प्रमाणीकरण ईस्थान", isCompleted: false, date: nil),
        ProgressStep(id: 6, title: "प्रमाणीकरण पठाउनु", isCompleted: false, date: nil)
    ]
    
    var completedCount: Int {
        progressSteps.filter { $0.isCompleted }.count
    }
    
    var body: some View {
        ZStack {
            FormBackgroundGradient()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                if selectedTab == 0 {
                    ScrollView {
                        VStack(spacing: 0) {
                            headerSection
                            contentSection
                        }
                        .padding(.bottom, 80) // Add padding to prevent content from being hidden behind tab bar
                    }
                } else if selectedTab == 1 {
                    ProfileView()
                } else if selectedTab == 2 {
                    SettingsView()
                }
                
                Spacer(minLength: 0)
                
                // Bottom Tab Bar
                bottomTabBar
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .overlay(notificationOverlay, alignment: .topTrailing)
        .ignoresSafeArea(.container, edges: .bottom) // This removes the bottom gap
        .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
    }
    
    private var headerSection: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                Image("SplashLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("ई-पहिचान")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(isDarkMode ? .white : .primary)
                    
                    Text("Dashboard")
                        .font(.subheadline)
                        .foregroundColor(isDarkMode ? .white.opacity(0.7) : .secondary)
                }
                
                Spacer()
                
                Button(action: { showNotifications.toggle() }) {
                    ZStack(alignment: .topTrailing) {
                        Image(systemName: "bell.fill")
                            .font(.system(size: 22))
                            .foregroundColor(isDarkMode ? .white.opacity(0.9) : .primary)
                        
                        if hasUnreadSteps {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 10, height: 10)
                                .offset(x: 4, y: -4)
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
        }
        .padding(.bottom, 24)
    }
    
    private var hasUnreadSteps: Bool {
        progressSteps.contains(where: { !$0.isRead })
    }
    
    private var contentSection: some View {
        VStack(spacing: 24) {
            statusCard
            progressSection
            Spacer().frame(height: 40)
        }
    }
    
    private var bottomTabBar: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(isDarkMode ? Color.white.opacity(0.2) : Color(.separator))
            
            HStack(spacing: 0) {
                // Home Tab
                Button(action: { selectedTab = 0 }) {
                    VStack(spacing: 6) {
                        Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                            .font(.system(size: 22))
                        Text("होम")
                            .font(.system(size: 12, weight: selectedTab == 0 ? .semibold : .regular))
                    }
                    .foregroundColor(selectedTab == 0 ? Color.activeBlue : (isDarkMode ? .white.opacity(0.6) : .secondary))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                }
                
                // Profile Tab
                Button(action: { selectedTab = 1 }) {
                    VStack(spacing: 6) {
                        Image(systemName: selectedTab == 1 ? "person.fill" : "person")
                            .font(.system(size: 22))
                        Text("मेरो प्रोफाइल")
                            .font(.system(size: 12, weight: selectedTab == 1 ? .semibold : .regular))
                    }
                    .foregroundColor(selectedTab == 1 ? (isDarkMode ? .darkModeIcon : Color.activeBlue) : (isDarkMode ? .white.opacity(0.6) : .secondary))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                }
                
                // Settings Tab
                Button(action: { selectedTab = 2 }) {
                    VStack(spacing: 6) {
                        Image(systemName: selectedTab == 2 ? "gearshape.fill" : "gearshape")
                            .font(.system(size: 22))
                        Text("सेटिङ")
                            .font(.system(size: 12, weight: selectedTab == 2 ? .semibold : .regular))
                    }
                    .foregroundColor(selectedTab == 2 ? Color.activeBlue : (isDarkMode ? .white.opacity(0.6) : .secondary))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                }
            }
            .padding(.bottom, getSafeAreaBottom()) // Add safe area padding inside the tab bar
            .background(
                (isDarkMode ? Color.black.opacity(0.3) : Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
            )
        }
    }
    
    // Helper function to get bottom safe area
    private func getSafeAreaBottom() -> CGFloat {
        let keyWindow = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
        
        return keyWindow?.safeAreaInsets.bottom ?? 0
    }
    
    private var statusCard: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.activeBlue.opacity(0.15))
                    .frame(width: 70, height: 70)
                
                Image(systemName: "person.crop.circle.badge.exclamationmark")
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(isDarkMode ? .darkModeIcon : Color.activeBlue)
            }
            
            VStack(spacing: 8) {
                Text("तपाईं प्रमाणित हुनु वायको छैन")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(isDarkMode ? .white : .primary)
                    .multilineTextAlignment(.center)
                
                Text("प्रमाणीकरण प्रक्रिया पूरा गर्नुहोस्")
                    .font(.subheadline)
                    .foregroundColor(isDarkMode ? .white.opacity(0.7) : .secondary)
                    .multilineTextAlignment(.center)
            }
            
            NavigationLink(destination: NameEntryView()) {
                Text("प्रमाणित गर्नुहोस्")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.activeBlue)
                    .cornerRadius(14)
            }
            .buttonStyle(.plain)
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isDarkMode ? Color.white.opacity(0.2) : Color(.separator), lineWidth: 1)
        )
        .padding(.horizontal, 24)
    }
    
    private var progressSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("प्रगति")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(isDarkMode ? .white : .primary)
                
                Spacer()
                
                Text("\(completedCount)/\(progressSteps.count)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(isDarkMode ? .darkModeIcon : Color.activeBlue)
            }
            
            progressBar
            
            VStack(spacing: 12) {
                ForEach(Array(progressSteps.enumerated()), id: \.element.id) { index, step in
                    ProgressStepRow(
                        step: step,
                        isLast: index == progressSteps.count - 1,
                        isDarkMode: isDarkMode
                    )
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isDarkMode ? Color.white.opacity(0.2) : Color(.separator), lineWidth: 1)
        )
        .padding(.horizontal, 24)
    }
    
    private var progressBar: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.tertiarySystemBackground))
                    .frame(height: 8)
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.activeBlue)
                    .frame(width: geometry.size.width * CGFloat(completedCount) / CGFloat(progressSteps.count), height: 8)
            }
        }
        .frame(height: 8)
    }
    
    private var notificationOverlay: some View {
        Group {
            if showNotifications {
                let notificationItems = progressSteps.map { step -> NotificationItem in
                    NotificationItem(
                        id: UUID(),
                        message: step.isCompleted ? "\(step.title) पूरा भयो" : "\(step.title) बाँकी छ",
                        type: step.isCompleted ? .success : .info,
                        time: step.date ?? "अहिले",
                        isRead: step.isRead
                    )
                }
                
                NotificationCardView(notifications: notificationItems)
                    .frame(maxWidth: 300)
                    .padding(.trailing, 24)
                    .padding(.top, 80)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
    }
}

// Progress Step Model
struct ProgressStep: Identifiable {
    let id: Int
    let title: String
    var isCompleted: Bool
    var date: String?
    var isRead: Bool = false
}

// Progress Step Row Component
struct ProgressStepRow: View {
    let step: ProgressStep
    let isLast: Bool
    let isDarkMode: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Connector Line
            VStack(spacing: 0) {
                Circle()
                    .fill(step.isCompleted ? Color.activeBlue : (isDarkMode ? Color.white.opacity(0.3) : Color(.separator)))
                    .frame(width: 24, height: 24)
                    .overlay(
                        Circle()
                            .stroke(isDarkMode ? Color.white.opacity(0.2) : Color(.separator), lineWidth: 2)
                            .background(
                                Circle()
                                    .fill(step.isCompleted ? Color.activeBlue : Color.clear)
                            )
                    )
                    .overlay(
                        Group {
                            if step.isCompleted {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                    )
                
                if !isLast {
                    Rectangle()
                        .fill(step.isCompleted ? Color.activeBlue : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)))
                        .frame(width: 2)
                        .frame(maxHeight: .infinity)
                }
            }
            .frame(width: 24)
            
            // Content
            VStack(alignment: .leading, spacing: 4) {
                Text(step.title)
                    .font(.body)
                    .fontWeight(step.isCompleted ? .semibold : .regular)
                    .foregroundColor(step.isCompleted ? (isDarkMode ? .white : .primary) : (isDarkMode ? .white.opacity(0.7) : .secondary))
                
                if let date = step.date, step.isCompleted {
                    Text(date)
                        .font(.caption)
                        .foregroundColor(isDarkMode ? .white.opacity(0.6) : .secondary)
                } else if !step.isCompleted {
                    Text("बाँकी छ")
                        .font(.caption)
                        .foregroundColor(isDarkMode ? .white.opacity(0.6) : .secondary)
                }
            }
            
            Spacer()
        }
    }
}

// Notification Card Component (simplified from NotificationView)
struct NotificationCardView: View {
    let notifications: [NotificationItem]
    @Environment(\.colorScheme) private var colorScheme
    
    private var isDarkMode: Bool { colorScheme == .dark }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            let firstFive = Array(notifications.prefix(5))
            ForEach(Array(firstFive.enumerated()), id: \.element.id) { index, notification in
                DashboardNotificationRow(notification: notification)
                
                if index < firstFive.count - 1 {
                    Divider()
                        .background(isDarkMode ? Color.white.opacity(0.2) : Color(.separator))
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isDarkMode ? Color.white.opacity(0.2) : Color(.separator), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

// Simplified Notification Row for Dashboard (uses existing NotificationItem type)
struct DashboardNotificationRow: View {
    let notification: NotificationItem
    @Environment(\.colorScheme) private var colorScheme
    
    private var isDarkMode: Bool { colorScheme == .dark }
    
    private var iconColor: Color {
        switch notification.type {
        case .success: return .green
        case .error: return .red
        case .info: return Color.activeBlue
        }
    }
    
    private var iconName: String {
        switch notification.type {
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        case .info: return "info.circle.fill"
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: iconName)
                .font(.system(size: 18))
                .foregroundColor(iconColor)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(notification.message)
                    .font(.subheadline)
                    .foregroundColor(isDarkMode ? .white : .primary)
                    .multilineTextAlignment(.leading)
                
                Text(notification.time)
                    .font(.caption)
                    .foregroundColor(isDarkMode ? .white.opacity(0.6) : .secondary)
            }
            
            Spacer()
        }
        .padding(12)
    }
}

#Preview {
    NavigationView {
        DashboardView()
    }
}
