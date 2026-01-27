import SwiftUI

struct CitizenshipDetailEntryView: View {
    @State private var citizenshipNumber: String = ""
    @State private var jariMiti: String = ""
    @State private var selectedDistrict: String = ""
    @State private var showDistrictPicker = false
    @State private var showDatePicker = false
    @State private var selectedDate = Date()
    @State private var showConfirmation = false
    @State private var navigateToDashboard = false
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?

    private var isDarkMode: Bool { colorScheme == .dark }

    enum Field {
        case citizenshipNumber, jariMiti
    }

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

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }

    var body: some View {
        ZStack {
            FormBackgroundGradient()
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: 16)

                    VStack(spacing: 24) {
                        VStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(Color.activeBlue.opacity(0.15))
                                    .frame(width: 70, height: 70)

                                Image(systemName: "doc.text.fill")
                                    .font(.system(size: 32, weight: .semibold))
                                    .foregroundColor(isDarkMode ? .cyan : Color.activeBlue)
                            }

                            VStack(spacing: 6) {
                                Text("नागरिकता विवरण भर्नुहोस्")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(isDarkMode ? .white : .primary)
                                    .multilineTextAlignment(.center)

                                Text("कृपया आफ्नो नागरिकता विवरण सुरक्षित तरिकाले भर्नुहोस्")
                                    .font(.subheadline)
                                    .foregroundColor(isDarkMode ? .white.opacity(0.7) : .secondary)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 8)
                            }
                        }
                        .padding(.top, 8)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            hideKeyboard()
                        }

                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("नागरिकता नम्बर")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(isDarkMode ? .white.opacity(0.8) : .secondary)

                                TextField("", text: $citizenshipNumber)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(isDarkMode ? .white : Color(.label))
                                    .keyboardType(.numberPad)
                                    .padding(16)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(focusedField == .citizenshipNumber
                                                  ? (isDarkMode ? Color.white.opacity(0.2) : Color(.systemGray5))
                                                  : (isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground)))
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(focusedField == .citizenshipNumber
                                                    ? (isDarkMode ? Color.white.opacity(0.3) : Color(.systemGray3))
                                                    : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)),
                                                   lineWidth: focusedField == .citizenshipNumber ? 1.5 : 1)
                                    )
                                    .focused($focusedField, equals: .citizenshipNumber)
                            }

                            VStack(alignment: .leading, spacing: 10) {
                                Text("जारी मिति")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(isDarkMode ? .white.opacity(0.8) : .secondary)

                                Button(action: { showDatePicker = true }) {
                                    HStack {
                                        Text(jariMiti.isEmpty ? "YYYY/MM/DD" : jariMiti)
                                            .font(.body)
                                            .foregroundColor(jariMiti.isEmpty ? (isDarkMode ? .white.opacity(0.5) : .secondary) : (isDarkMode ? .white : .primary))
                                            .frame(maxWidth: .infinity, alignment: .leading)

                                        Image(systemName: "calendar")
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(isDarkMode ? .white.opacity(0.6) : .secondary)
                                    }
                                    .padding(16)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(showDatePicker ? Color.activeBlue : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)), lineWidth: showDatePicker ? 2 : 1)
                                    )
                                }
                                .buttonStyle(.plain)
                            }

                            VStack(alignment: .leading, spacing: 10) {
                                Text("जिल्ला")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(isDarkMode ? .white.opacity(0.8) : .secondary)

                                Button(action: { showDistrictPicker = true }) {
                                    HStack {
                                        Text(selectedDistrict.isEmpty ? "जिल्ला छान्नुहोस्" : selectedDistrict)
                                            .font(.body)
                                            .foregroundColor(selectedDistrict.isEmpty ? (isDarkMode ? .white.opacity(0.5) : .secondary) : (isDarkMode ? .white : .primary))

                                        Spacer()

                                        Image(systemName: "chevron.down")
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(isDarkMode ? .white.opacity(0.6) : .secondary)
                                    }
                                    .padding(16)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(showDistrictPicker ? Color.activeBlue : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)), lineWidth: showDistrictPicker ? 2 : 1)
                                    )
                                }
                                .buttonStyle(.plain)
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

                                Button(action: { showConfirmation = true }) {
                                    Text("पेश गर्नुहोस्")
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
                        .contentShape(Rectangle())
                        .onTapGesture {
                            hideKeyboard()
                        }

                        Spacer().frame(height: 20)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        hideKeyboard()
                    }
                }
                .scrollDismissesKeyboard(.interactively)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                hideKeyboard()
            }
        }
        .navigationTitle("नागरिकता")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showDistrictPicker) {
            DistrictPickerView(selectedDistrict: $selectedDistrict, districts: districts)
        }
        .sheet(isPresented: $showDatePicker) {
            NepaliDatePickerView(selectedDate: $selectedDate, jariMiti: $jariMiti, dateFormatter: dateFormatter)
        }
        .alert("पुष्टि गर्नुहोस्", isPresented: $showConfirmation) {
            Button("रद्द", role: .cancel) {}
            Button("पेश गर्नुहोस्") {
                navigateToDashboard = true
            }
        } message: {
            Text("के तपाईं यो विवरण पेश गर्न चाहनुहुन्छ?")
        }
        .background(
            NavigationLink(destination: DashboardView(), isActive: $navigateToDashboard) {
                EmptyView()
            }
        )
    }
}

struct ProvincePickerView: View {
    @Binding var selectedProvince: String
    let provinces: [String]
    @State private var searchText: String = ""
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) private var colorScheme

    private var isDarkMode: Bool { colorScheme == .dark }

    var filteredProvinces: [String] {
        searchText.isEmpty
            ? provinces
            : provinces.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        NavigationView {
            ZStack {
                FormBackgroundGradient()
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    VStack(spacing: 16) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(isDarkMode ? .white.opacity(0.6) : .secondary)
                                .padding(.leading, 16)
                            TextField("प्रदेश खोज्नुहोस्", text: $searchText)
                                .font(.body)
                                .foregroundColor(isDarkMode ? .white : .primary)
                                .padding(.vertical, 12)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(isDarkMode ? Color.white.opacity(0.2) : Color(.separator), lineWidth: 1)
                        )
                        .padding(.horizontal, 24)
                        .padding(.top, 16)
                        ScrollView {
                            VStack(spacing: 12) {
                                ForEach(filteredProvinces, id: \.self) { province in
                                    Button(action: {
                                        selectedProvince = province
                                        dismiss()
                                    }) {
                                        HStack {
                                            Text(province)
                                                .font(.body)
                                                .foregroundColor(isDarkMode ? .white : .primary)
                                            Spacer()
                                            if selectedProvince == province {
                                                Image(systemName: "checkmark")
                                                    .font(.system(size: 16, weight: .semibold))
                                                    .foregroundColor(Color.activeBlue)
                                            }
                                        }
                                        .padding(16)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(selectedProvince == province ? Color.activeBlue : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)), lineWidth: selectedProvince == province ? 2 : 1)
                                        )
                                    }
                                    .buttonStyle(.plain)
                                    .padding(.horizontal, 24)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }
            }
            .navigationTitle("प्रदेश छान्नुहोस्")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("रद्द") { dismiss() }
                        .foregroundColor(isDarkMode ? .cyan : Color.activeBlue)
                }
            }
        }
    }
}

struct DistrictPickerView: View {
    @Binding var selectedDistrict: String
    let districts: [String]
    @State private var searchText: String = ""
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) private var colorScheme

    private var isDarkMode: Bool { colorScheme == .dark }

    var filteredDistricts: [String] {
        if searchText.isEmpty {
            return districts
        } else {
            return districts.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                FormBackgroundGradient()
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    VStack(spacing: 16) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(isDarkMode ? .white.opacity(0.6) : .secondary)
                                .padding(.leading, 16)

                            TextField("जिल्ला खोज्नुहोस्", text: $searchText)
                                .font(.body)
                                .foregroundColor(isDarkMode ? .white : .primary)
                                .padding(.vertical, 12)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(isDarkMode ? Color.white.opacity(0.2) : Color(.separator), lineWidth: 1)
                        )
                        .padding(.horizontal, 24)
                        .padding(.top, 16)

                        ScrollView {
                            VStack(spacing: 12) {
                                ForEach(filteredDistricts, id: \.self) { district in
                                    Button(action: {
                                        selectedDistrict = district
                                        dismiss()
                                    }) {
                                        HStack {
                                            Text(district)
                                                .font(.body)
                                                .foregroundColor(isDarkMode ? .white : .primary)

                                            Spacer()

                                            if selectedDistrict == district {
                                                Image(systemName: "checkmark")
                                                    .font(.system(size: 16, weight: .semibold))
                                                    .foregroundColor(Color.activeBlue)
                                            }
                                        }
                                        .padding(16)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(selectedDistrict == district ? Color.activeBlue : (isDarkMode ? Color.white.opacity(0.2) : Color(.separator)), lineWidth: selectedDistrict == district ? 2 : 1)
                                        )
                                    }
                                    .buttonStyle(.plain)
                                    .padding(.horizontal, 24)
                                }
                            }
                            .padding(.vertical, 8)
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
                    .foregroundColor(Color.activeBlue)
                }
            }
        }
    }
}

struct NepaliDatePickerView: View {
    @Binding var selectedDate: Date
    @Binding var jariMiti: String
    let dateFormatter: DateFormatter
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) private var colorScheme

    private var isDarkMode: Bool { colorScheme == .dark }

    // Nepali months
    let nepaliMonths = [
        "बैशाख", "जेठ", "असार", "श्रावण", "भाद्र", "आश्विन",
        "कार्तिक", "मंसिर", "पौष", "माघ", "फाल्गुन", "चैत्र"
    ]

    // Nepali years (2080-2090 BS)
    let nepaliYears = Array(2080...2090).map { "\($0)" }

    @State private var selectedYear: String = "2080"
    @State private var selectedMonth: String = "बैशाख"
    @State private var selectedDay: String = "1"

    // Days in each Nepali month (simplified - in real app, use proper Nepali calendar)
    private var daysInMonth: [Int] {
        // Simplified: assuming 30 days for all months
        Array(1...30).map { $0 }
    }

    var body: some View {
        NavigationView {
            ZStack {
                FormBackgroundGradient()
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        VStack(spacing: 16) {
                            Text("वर्ष")
                                .font(.subheadline)
                                .foregroundColor(isDarkMode ? .white.opacity(0.8) : .secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(nepaliYears, id: \.self) { year in
                                        Button(action: { selectedYear = year }) {
                                            Text(year)
                                                .font(.body)
                                                .fontWeight(selectedYear == year ? .semibold : .regular)
                                                .foregroundColor(selectedYear == year ? .white : (isDarkMode ? .white.opacity(0.8) : .primary))
                                                .padding(.horizontal, 20)
                                                .padding(.vertical, 12)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .fill(selectedYear == year ? Color.activeBlue : (isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground)))
                                                )
                                        }
                                    }
                                }
                                .padding(.horizontal, 24)
                            }
                        }

                        VStack(spacing: 16) {
                            Text("महिना")
                                .font(.subheadline)
                                .foregroundColor(isDarkMode ? .white.opacity(0.8) : .secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(nepaliMonths, id: \.self) { month in
                                        Button(action: { selectedMonth = month }) {
                                            Text(month)
                                                .font(.body)
                                                .fontWeight(selectedMonth == month ? .semibold : .regular)
                                                .foregroundColor(selectedMonth == month ? .white : (isDarkMode ? .white.opacity(0.8) : .primary))
                                                .padding(.horizontal, 20)
                                                .padding(.vertical, 12)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .fill(selectedMonth == month ? Color.activeBlue : (isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground)))
                                                )
                                        }
                                    }
                                }
                                .padding(.horizontal, 24)
                            }
                        }

                        VStack(spacing: 16) {
                            Text("दिन")
                                .font(.subheadline)
                                .foregroundColor(isDarkMode ? .white.opacity(0.8) : .secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 5), spacing: 8) {
                                ForEach(daysInMonth, id: \.self) { day in
                                    Button(action: { selectedDay = "\(day)" }) {
                                        Text("\(day)")
                                            .font(.body)
                                            .fontWeight(selectedDay == "\(day)" ? .semibold : .regular)
                                            .foregroundColor(selectedDay == "\(day)" ? .white : (isDarkMode ? .white.opacity(0.8) : .primary))
                                            .frame(width: 50, height: 50)
                                            .background(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(selectedDay == "\(day)" ? Color.activeBlue : (isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground)))
                                            )
                                    }
                                }
                            }
                            .padding(.horizontal, 24)
                        }

                        Button(action: {
                            // Convert Nepali date to format (simplified - in real app, convert properly)
                            let monthIndex = nepaliMonths.firstIndex(of: selectedMonth) ?? 0
                            let monthNumber = String(format: "%02d", monthIndex + 1)
                            let dayNumber = String(format: "%02d", Int(selectedDay) ?? 1)
                            jariMiti = "\(selectedYear)/\(monthNumber)/\(dayNumber)"
                            dismiss()
                        }) {
                            Text("छान्नुहोस्")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(Color.activeBlue)
                                .cornerRadius(14)
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 8)
                    }
                    .padding(.vertical, 24)
                }
            }
            .navigationTitle("मिति छान्नुहोस्")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("रद्द") {
                        dismiss()
                    }
                    .foregroundColor(Color.activeBlue)
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        CitizenshipDetailEntryView()
    }
}
