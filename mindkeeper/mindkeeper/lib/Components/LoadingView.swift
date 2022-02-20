import SwiftUI

struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { _ in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                HStack {
                    Text("Loading")
                    Text(String(repeating: " ", count: 3))
                    ProgressView()
                }
                .padding(20)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(10)
                .opacity(self.isShowing ? 1 : 0)

            }
        }
    }

}

