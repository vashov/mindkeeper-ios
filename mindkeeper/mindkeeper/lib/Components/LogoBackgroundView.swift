import SwiftUI

struct LogoBackgroundView: View {
    var body: some View {
        Image("LogoBackground")
            .resizable()
            .scaledToFit()
            .padding()
    }
}

struct LogoBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        LogoBackgroundView()
    }
}
