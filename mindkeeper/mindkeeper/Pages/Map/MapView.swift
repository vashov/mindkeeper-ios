import SwiftUI

//struct AnyMapAnnotationProtocol: MapAnnotationProtocol {
//  let _annotationData: _MapAnnotationData
//  let value: Any
//
//  init<WrappedType: MapAnnotationProtocol>(_ value: WrappedType) {
//    self.value = value
//    _annotationData = value._annotationData
//  }
//}

struct MapView: View {
    
//    @ObservedObject var viewModel = MapViewModel()

    var body: some View {
        Spacer()
//        NavigationView {
//            ZStack {
//                Map(
//                    coordinateRegion: $viewModel.region,
//                    interactionModes: MapInteractionModes.all,
//                    showsUserLocation: true,
//    //                userTrackingMode: $userTrackingMode,
//                    annotationItems: viewModel.markers) { marker in
//                    MapAnnotation(coordinate: marker.coordinate) {
//                      ZStack {
////                        NavigationLink(destination: QueryView(queryId: marker.queryId)) {
////                            Image(systemName: "exclamationmark.circle.fill")
////                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
////                                .font(.system(size: 30))
////                            }
//                        }
//                    }
//                }
//
//
//                Image(systemName: "viewfinder")
//
////                if viewModel.canCreateTask {
////                    VStack {
////                        Spacer()
////
//////                        NavigationLink(
//////                            destination: QueryView(
//////                                latitude: viewModel.region.center.latitude,
//////                                longitude: viewModel.region.center.longitude)
//////                        ) {
//////                            Text("Create Task")
//////                                .foregroundColor(.foregroundSecond)
//////                                .bold()
//////                                .padding(.vertical)
//////                                .frame(width: UIScreen.main.bounds.width - 30)
//////                                .background(Color.backgroundSecond.opacity(0.8))
//////                                .clipShape(Capsule())
//////                                .padding()
//////                        }
////                    }
////                }
//            }
//            .onAppear(perform: viewModel.initialize)
//            .navigationBarTitleDisplayMode(.inline)
//        }
        
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
