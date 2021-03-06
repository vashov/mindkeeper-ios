import SwiftUI

struct CustomTextField: View {
    var image: String
    var placeHolder: String
    var isSecurityField = false
    @Binding var txt: String

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
//            Image(systemName: image)
//                .font(.system(size: 24))
//                .foregroundColor(.foregroundSecond)
//                .frame(width: 60, height: 60)
//                .background(Color.backgroundSecond)
//                .clipShape(Circle())

            ZStack {
                if isSecurityField {
                    SecureField(placeHolder, text: $txt)
                        
                } else {
                    TextField(placeHolder, text: $txt)
                }
            }
                .padding(.horizontal)
                .frame(height: 60)
                .foregroundColor(Color.foregroundPrimary)
                .background(Color.backgroundSecond.opacity(0.2))
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
        }
//        .padding(.horizontal)
    }
}
