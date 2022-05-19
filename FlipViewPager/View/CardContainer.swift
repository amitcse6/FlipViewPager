import SwiftUI
import Foundation

struct CardContainer: View {
    @State private var imageSize: CGSize = CGSize.zero
    @State private var firstDegree: CGFloat = CGFloat(180)
    @State private var secondDegree: CGFloat = CGFloat(180)
    @State private var anchorLeft: UnitPoint = .leading
    @State private var anchorRight: UnitPoint = .trailing
    @State private var mainSideLeft: UnitPoint = .leading
    @State private var mainSideRight: UnitPoint = .trailing
    
    @State private var geometrySize: CGSize
    
    init(geometrySize: CGSize) {
        self.geometrySize = geometrySize
    }
    
    var body: some View {
        let firstLeftCard = CardView(mainSide: $mainSideLeft, anchor: $anchorLeft, degree: $firstDegree, geometrySize: $geometrySize)
            .background(GeometryReader { proxy in Color.clear.onAppear() { imageSize = proxy.size } })
        let firstRightCard = CardView(mainSide: $mainSideLeft, anchor: $anchorRight, degree: $firstDegree, geometrySize: $geometrySize)
            .background(GeometryReader { proxy in Color.clear.onAppear() { imageSize = proxy.size } })
        
        let secondLeftCard = CardView(mainSide: $mainSideRight, anchor: $anchorLeft, degree: $secondDegree, geometrySize: $geometrySize)
            .background(GeometryReader { proxy in Color.clear.onAppear() { imageSize = proxy.size } })
        let secondRightCard = CardView(mainSide: $mainSideRight, anchor: $anchorRight, degree: $secondDegree, geometrySize: $geometrySize)
            .background(GeometryReader { proxy in Color.clear.onAppear() { imageSize = proxy.size } })
        
        return ZStack(alignment: .center)  {
            VStack(alignment: .center, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    
                    VStack(spacing: 0) {
                        VStack(spacing: 0) {
                            ZStack(alignment: .trailing) {
                                firstLeftCard.frame(width: imageSize.width/2, height: imageSize.height, alignment: .leading).clipped()
                                    .offset(x: -imageSize.width/4, y: 0)
                                    .zIndex(1)
                                
                                firstRightCard.frame(width: imageSize.width/2, height: imageSize.height, alignment: .trailing).clipped()
                                    .offset(x: imageSize.width/4, y: 0)
                                    .rotation3DEffect(.degrees(-firstDegree), axis: (x: 0, y: 1, z: 0), anchor: .center)
                                    .zIndex(2)
                            }.offset(x: imageSize.width/4, y: 0)
                            ZStack {
                                VStack { Spacer(); Slider(value: $firstDegree, in: 0.0...180.0) }
                            }
                        }
                    }
                    .background(Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)))
                    .zIndex(firstDegree < 90 ? 1 : 0)
                    
                    VStack(spacing: 0) {
                        VStack(spacing: 0) {
                            ZStack(alignment: .leading) {
                                secondLeftCard.frame(width: imageSize.width/2, height: imageSize.height, alignment: .leading).clipped()
                                    .offset(x: -imageSize.width/4, y: 0)
                                    .rotation3DEffect(.degrees(secondDegree), axis: (x: 0, y: 1, z: 0), anchor: .center)
                                    .zIndex(2)
                                
                                secondRightCard.frame(width: imageSize.width/2, height: imageSize.height, alignment: .trailing).clipped()
                                    .offset(x: imageSize.width/4, y: 0)
                                    .zIndex(1)
                            }.offset(x: -imageSize.width/4, y: 0)
                            ZStack {
                                VStack { Spacer(); Slider(value: $secondDegree, in: 0.0...180.0) }
                            }
                        }
                    }
                    .background(Color(#colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)))
                    .zIndex(secondDegree < 90 ? 1 : 0)
                    
                }.background(Color(#colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)))
            }.background(Color(#colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)))
        }.background(Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)))
    }
}

struct CardContainer_Previews: PreviewProvider {
    static var previews: some View {
        CardContainer(geometrySize: CGSize.zero)
    }
}
