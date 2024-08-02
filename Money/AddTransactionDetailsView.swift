import SwiftUI

struct AddTransactionDetailsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State var amount: String;
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.headline.weight(.semibold))
                        .padding(12)
                        .background(Color(.gray))
                        .foregroundColor(Color(.systemBackground))
                        .clipShape(Circle())
                }
                .padding()
            }
            
            HStack {
                Text("R$")
                    .font(.system(size: 32, weight: .regular))
                    .foregroundColor(.gray)
                Text(amount)
                    .font(.system(size: 48, weight: .bold))
            }
            
            Button(action: {
                showDatePicker.toggle()
            }) {
                HStack {
                    Image(systemName: "calendar")
                    Text(dateFormatter.string(from: selectedDate))
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            }
            
            Spacer()
            
            
            VStack {
                Text("Create")
                    .font(.title.weight(.medium))
                    .foregroundColor(Color(.systemBackground))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,12)
                    .background(Color(.label))
                    .cornerRadius(12)
            }.padding(.horizontal,40)
            
        }.sheet(isPresented: $showDatePicker) {
            BottomSheetDatePicker(selectedDate: $selectedDate, isPresented: $showDatePicker)
        }
    }
    
}

struct BottomSheetDatePicker: View {
    @Binding var selectedDate: Date
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                Spacer()
                Text("Select Date")
                    .font(.headline)
                Spacer()
                Button("Done") {
                    isPresented = false
                }
            }
            .padding()
            
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
        }
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .padding(.bottom, 20)
    }
}

#Preview {
    AddTransactionDetailsView(amount: "5.00")
}
