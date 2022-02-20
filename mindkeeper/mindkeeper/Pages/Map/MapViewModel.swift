import Foundation
import SwiftUI
import MapKit
import CoreLocation

//struct Marker: Identifiable {
//    let id = UUID()
//    var location: CLLocationCoordinate2D
//}

class MapViewModel : ObservableObject {
    
    @Inject var appState: AppState
    
    let startPosition = CLLocationCoordinate2D(
        latitude: 25.7617,
        longitude: 80.1918
    )
    
    @Published var markers: [QueryPlace] = []
    
    @Published var userTrackingMode: MapUserTrackingMode = .follow
    
    @Published var region: MKCoordinateRegion
    
    @Published var showQueryDetailsPage = false
    
    @Published var isLoadingQueries = false
    
    init() {
//        markers = [QueryPlace(queryId: 5, name: "Some place", latitude: startPosition.latitude, longitude: startPosition.longitude)]
        
        region = MKCoordinateRegion(
            center: startPosition,
            span: MKCoordinateSpan(
                latitudeDelta: 10,
                longitudeDelta: 10
            )
        )
    }
    
//    func addQuery() {
//
//
//        let newPlace = QueryPlace(
//            queryId: 10,
//            name: "SomeQuery" ,
//            latitude: region.center.latitude,
//            longitude: region.center.longitude)
//
//        markers.append(newPlace)
//    }
    
    func initialize() {
        print("MapViewModel initialize")
        loadQueries()
    }
    
    func loadQueries() {
        isLoadingQueries = true
        
//        queriesRepository.getAll() { result in
//            switch result {
//            case .success(let queries):
//                self.setQueries(queries)
//            case .failure(let error):
//                print(error)
//            }
//
//            DispatchQueue.main.async {
//                self.isLoadingQueries = false
//            }
//        }
    }
    
}
