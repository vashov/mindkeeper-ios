import SwiftUI

struct ProgressBar: View {
    @Binding var value: Double
    
//    let height: CGFloat = 20
    
    var body: some View {
//        SingleAxisGeometryReader(axis: .horizontal, alignment: .trailing, content: { width in
//            ZStack {
//
//                Rectangle().frame(width: width, height: height)
//                    .opacity(0.3)
//                    .foregroundColor(Color(UIColor.systemTeal))
//
//                Rectangle().frame(width: min(CGFloat(self.value)*width, width), height: height)
//                    .foregroundColor(Color(UIColor.systemBlue))
//                    .animation(.linear)
//            }.cornerRadius(45.0)
//        })
        
        GeometryReader { geometry in
            Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                .opacity(0.3)
                .foregroundColor(Color(UIColor.systemTeal))

            Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                .foregroundColor(Color(UIColor.systemBlue))
                .animation(.linear)
        }.cornerRadius(45.0)
    }
}

//struct ProgressBarContent: View {
//    @Binding var value: Double
//
//    var body: some View {
//
//    }
//}


struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value: .constant(0.20))
    }
}
