import SwiftUI

struct LogoView: View {
    var body: some View {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width - 100,
                       height: UIScreen.main.bounds.width - 100)
                .padding()
    }
}

struct LogoComponent_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
