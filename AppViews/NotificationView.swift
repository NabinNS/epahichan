import SwiftUI

struct NotificationView: View {
    @State private var showNotifications = false
    @State private var notifications: [NotificationItem] = [
        NotificationItem(
            id: UUID(),
            message: "तपाईंको पहिचान प्रमाणीकरण अनुरोध अस्वीकृत गरिएको छ",
            type: .error,
            time: "२ घण्टा अघि",
            isRead: false
        ),
        NotificationItem(
            id: UUID(),
            message: "तपाईंको पहिचान प्रमाणीकरण स्वीकृत गरिएको छ",
            type: .success,
            time: "१ दिन अघि",
            isRead: false
        ),
        NotificationItem(
            id: UUID(),
            message: "तपाईंको पहिचान प्रमाणीकरण प्रक्रियामा छ",
            type: .info,
            time: "२ दिन अघि",
            isRead: true
        ),
        NotificationItem(
            id: UUID(),
            message: "नयाँ ईस्थान मा प्रमाणीकरण अनुरोध पठाइएको छ",
            type: .success,
            time: "३ दिन",
            isRead: true
        ),
        NotificationItem(
            id: UUID(),
            message: "प्रमाणीकरण दस्तावेज अपूर्ण छ",
            type: .error,
            time: "४ दिन",
            isRead: true
        )
    ]



    var unreadCount: Int {
        notifications.filter { !$0.isRead }.count
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topTrailing) {
                // Full-screen tap detector when notifications are shown
                if showNotifications {
                    Color.clear
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                showNotifications = false
                            }
                        }
                }
                
                VStack(alignment: .trailing, spacing: 0) {
                    Button(action: {
                        withAnimation {
                            showNotifications.toggle()
                        }
                    }) {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "bell.fill")
                                .font(.title3)
                                .foregroundColor(.primary)
                                .frame(width: 44, height: 44)
                            
                            if unreadCount > 0 {
                                Text("\(unreadCount)")
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(4)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 8, y: -8)
                            }
                        }
                    }
                    .padding(.trailing, 16)
                    .padding(.top, 8)
                    
                    if showNotifications {
                        NotificationCard(
                            notifications: $notifications,
                            onDismiss: {
                                withAnimation {
                                    showNotifications = false
                                }
                            }
                        )
                        .padding(.trailing, 16)
                        .padding(.top, 8)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                        .onTapGesture {
                            // Prevent tap from propagating to background
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
    }
}

struct NotificationItem: Identifiable {
    let id: UUID
    let message: String
    let type: NotificationType
    let time: String
    var isRead: Bool
}

enum NotificationType {
    case success
    case error
    case info
    
    var color: Color {
        switch self {
        case .success:
            return .green
        case .error:
            return .red
        case .info:
            return .blue
        }
    }
    
    var icon: String {
        switch self {
        case .success:
            return "checkmark.circle.fill"
        case .error:
            return "xmark.circle.fill"
        case .info:
            return "info.circle.fill"
        }
    }
}

struct NotificationCard: View {
    @Binding var notifications: [NotificationItem]
    let onDismiss: () -> Void
    @Environment(\.colorScheme) private var colorScheme
    
    private var isDarkMode: Bool { colorScheme == .dark }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("सूचना")
                    .font(.headline)
                
                Spacer()
                
                Button(action: onDismiss) {
                    Image(systemName: "xmark")
                        .foregroundColor(.secondary)
                }
            }
            .padding(16)
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(notifications) { notification in
                        NotificationRow(notification: notification) {
                            if let index = notifications.firstIndex(where: { $0.id == notification.id }) {
                                notifications[index].isRead = true
                            }
                        }
                        
                        if notification.id != notifications.last?.id {
                            Divider()
                        }
                    }
                }
            }
            .frame(maxHeight: 400)
        }
        .frame(width: 320)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isDarkMode ? Color(.secondarySystemBackground) : Color(.systemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isDarkMode ? Color.white.opacity(0.15) : Color.blue.opacity(0.2), lineWidth: 1)
        )
    }
}

struct NotificationRow: View {
    let notification: NotificationItem
    let onTap: () -> Void


    var body: some View {
        Button(action: onTap) {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: notification.type.icon)
                    .foregroundColor(notification.type.color)
                    .font(.title3)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(notification.message)
                        .font(.body)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    
                    Text(notification.time)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if !notification.isRead {
                    Circle()
                        .fill(notification.type.color)
                        .frame(width: 8, height: 8)
                }
            }
            .padding(12)
            .background(notification.isRead ? Color.clear : Color(notification.type.color).opacity(0.05))
        }
    }
}

#Preview {
    NavigationView {
        VStack {
            Spacer()
            HStack {
                Spacer()
                NotificationView()
                    .padding()
            }
        }
    }
}
