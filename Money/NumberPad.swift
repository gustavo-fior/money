import SwiftUI

struct NumberPad: View {
    @Binding var amount: String
    
    let maxAmountLength = 8
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 30) {
                numberButton(1)
                numberButton(2)
                numberButton(3)
            }
            HStack(spacing: 30) {
                numberButton(4)
                numberButton(5)
                numberButton(6)
            }
            HStack(spacing: 30) {
                numberButton(7)
                numberButton(8)
                numberButton(9)
            }
            HStack(spacing: 30) {
                decimalButton()
                numberButton(0)
                backspaceButton()
            }
        }
    }
    
    private func numberButton(_ number: Int) -> some View {
        let decimalLengthIsNotTwo = !(amount.contains(".") && amount.split(separator: ".").last?.count == 2)
        
        let lengthLimitIsNotOver = amount.contains(".") ?
        amount.split(separator: ".").first!.count < maxAmountLength :
        amount.count < maxAmountLength
        
        return Button(action: {
            if amount == "0" {
                amount = String(number)
            } else {
                if decimalLengthIsNotTwo && lengthLimitIsNotOver {
                    amount += String(number)
                }
            }
        }) {
            Text(number.description)
                .font(.largeTitle)
                .frame(width: 80, height: 80)
                .foregroundColor(.primary)
        }
    }
    
    private func decimalButton() -> some View {
        Button(action: {
            if !amount.contains(".") && amount.count < maxAmountLength {
                amount += "."
            }
        }) {
            Text(".")
                .font(.largeTitle)
                .frame(width: 80, height: 80)
                .foregroundColor(.primary)
        }
    }
    
    private func backspaceButton() -> some View {
        Button(action: {
            if amount.isEmpty {
                amount = "0"
                
            } else {
                amount.removeLast()
                
                if (amount.last == ".") {
                    amount.removeLast()
                }
            }
        }) {
            Image(systemName: "delete.left")
                .font(.title)
                .frame(width: 80, height: 80)
                .foregroundColor(.primary)
        }
    }
}


#Preview {
    AddTransactionView()
}
