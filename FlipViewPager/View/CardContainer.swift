import SwiftUI
import Foundation

struct CardContainer: View {
    @State private var imageSize: CGSize = CGSize.zero
    @State private var firstDegree: CGFloat = CGFloat(180)
    @State private var firstOffset = CGSize.zero
    @State private var firstCounter = 0
    @State private var secondDegree: CGFloat = CGFloat(180)
    @State private var secondOffset = CGSize.zero
    @State private var secondCounter = 0
    @State private var anchorLeft: UnitPoint = .leading
    @State private var anchorRight: UnitPoint = .trailing
    @State private var mainSideLeft: UnitPoint = .leading
    @State private var mainSideRight: UnitPoint = .trailing
    
    @State private var geometrySize: CGSize
    @State private var cardModel: CardModel
    
    init(geometrySize: CGSize, cardModel: CardModel) {
        self.geometrySize = geometrySize
        self.cardModel = cardModel
    }
    
    var body: some View {
        let firstLeftCard = CardView(mainSide: $mainSideLeft, anchor: $anchorLeft, degree: $firstDegree, counter: $firstCounter, geometrySize: $geometrySize, cardModel: $cardModel)
            .background(GeometryReader { proxy in Color.clear.onAppear() { imageSize = proxy.size } })
        let firstRightCard = CardView(mainSide: $mainSideLeft, anchor: $anchorRight, degree: $firstDegree, counter: $secondCounter, geometrySize: $geometrySize, cardModel: $cardModel)
            .background(GeometryReader { proxy in Color.clear.onAppear() { imageSize = proxy.size } })
        
        let secondLeftCard = CardView(mainSide: $mainSideRight, anchor: $anchorLeft, degree: $secondDegree, counter: $firstCounter, geometrySize: $geometrySize, cardModel: $cardModel)
            .background(GeometryReader { proxy in Color.clear.onAppear() { imageSize = proxy.size } })
        let secondRightCard = CardView(mainSide: $mainSideRight, anchor: $anchorRight, degree: $secondDegree, counter: $secondCounter, geometrySize: $geometrySize, cardModel: $cardModel)
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
                            }
                            .offset(x: imageSize.width/4, y: 0)
                            ZStack {
                                VStack { Spacer(); Slider(value: $firstDegree, in: 0.0...180.0) }
                            }
                        }
                    }
                    .background(Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)))
                    .zIndex(firstDegree < 90 ? 1 : 0)
//                    .zIndex(1)
                    .onTapGesture {
                        print("firstCounter: \(firstCounter)")
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                self.firstOffset = gesture.translation
                            }
                            .onEnded { _ in
                                if self.firstOffset.height > 0 && self.firstCounter == 0  {
                                    print("firstDecrementAnimation: \(self.firstCounter) firstDegree: \(self.firstDegree)")
                                    if self.firstDegree > 0 {
                                        firstIncrementAnimation()
                                        
                                    }
                                } else if self.firstOffset.height < 0 && self.firstCounter == 1 {
                                    print("firstDecrementAnimation: \(self.firstCounter) firstDegree: \(self.firstDegree)")
                                    firstDecrementAnimation()
                                } else {
                                    self.firstOffset = .zero
                                }
                            })
                    
                    
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
                            }
                            .offset(x: -imageSize.width/4, y: 0)
                            ZStack {
                                VStack { Spacer(); Slider(value: $secondDegree, in: 0.0...180.0) }
                            }
                        }
                    }
                    .background(Color(#colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)))
                    .zIndex(secondDegree < 90 ? 1 : 0)
//                    .zIndex(1)
                    .onTapGesture {
                        print("secondCounter: \(secondCounter)")
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                self.secondOffset = gesture.translation
                            }
                            .onEnded { _ in
                                if self.secondOffset.height > 0 && self.secondCounter == 0  {
                                    print("secondDecrementAnimation: \(self.secondCounter) secondDegree: \(self.secondDegree)")
                                    if self.secondDegree > 0 {
                                        secondIncrementAnimation()
                                        
                                    }
                                } else if self.secondOffset.height < 0 && self.secondCounter == 1 {
                                    print("secondDecrementAnimation: \(self.secondCounter) secondDegree: \(self.secondDegree)")
                                    secondDecrementAnimation()
                                } else {
                                    self.secondOffset = .zero
                                }
                            })
                    
                }.background(Color(#colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)))
            }.background(Color(#colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)))
        }.background(Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)))
    }
    
    func firstIncrementAnimation() {
        if firstDegree == 180 {
            withAnimation(.linear(duration: 0.15)) {
                self.firstDegree = 90
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                
                withAnimation(.easeInOut(duration: 0.15)){
                    self.firstCounter += 1
                    self.firstDegree = 0
                }
            }
        } else if firstDegree == 0 || firstDegree == 360 {
            if firstDegree == 0{
                self.firstDegree = 360
            }
            withAnimation(.linear(duration: 0.15)) {
                self.firstDegree -= 90
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                withAnimation(.easeIn(duration: 0)){
                    self.firstCounter += 1
                }
                withAnimation(.easeInOut(duration: 0.15)){
                    self.firstDegree = 180
                }
            }
        }
    }
    
    func firstDecrementAnimation() {
        if firstDegree == 180{
            withAnimation(.linear(duration: 0.15)) {
                self.firstDegree = 270
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                withAnimation(.easeInOut(duration: 0.15)){
                    self.firstCounter -= 1
                    self.firstDegree = 360
                }
            }
        } else if firstDegree == 0 || firstDegree == 360 {
            if firstDegree == 360{
                self.firstDegree = 0
            }
            withAnimation(.linear(duration: 0.15)) {
                self.firstDegree = 90
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                withAnimation(.easeIn(duration: 0)){
                    self.firstCounter -= 1
                }
                withAnimation(.easeInOut(duration: 0.15)){
                    self.firstDegree = 180
                }
            }
        }
    }
    
    func secondIncrementAnimation() {
        if secondDegree == 180 {
            withAnimation(.linear(duration: 0.15)) {
                self.secondDegree = 90
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                
                withAnimation(.easeInOut(duration: 0.15)){
                    self.secondCounter += 1
                    self.secondDegree = 0
                }
            }
        } else if secondDegree == 0 || secondDegree == 360 {
            if secondDegree == 0{
                self.secondDegree = 360
            }
            withAnimation(.linear(duration: 0.15)) {
                self.secondDegree -= 90
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                withAnimation(.easeIn(duration: 0)){
                    self.secondCounter += 1
                }
                withAnimation(.easeInOut(duration: 0.15)){
                    self.secondDegree = 180
                }
            }
        }
    }
    
    func secondDecrementAnimation() {
        if secondDegree == 180{
            withAnimation(.linear(duration: 0.15)) {
                self.secondDegree = 270
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                withAnimation(.easeInOut(duration: 0.15)){
                    self.secondCounter -= 1
                    self.secondDegree = 360
                }
            }
        } else if secondDegree == 0 || secondDegree == 360 {
            if secondDegree == 360{
                self.secondDegree = 0
            }
            withAnimation(.linear(duration: 0.15)) {
                self.secondDegree = 90
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                withAnimation(.easeIn(duration: 0)){
                    self.secondCounter -= 1
                }
                withAnimation(.easeInOut(duration: 0.15)){
                    self.secondDegree = 180
                }
            }
        }
    }
}

struct CardContainer_Previews: PreviewProvider {
    static var previews: some View {
        CardContainer(geometrySize: CGSize.zero, cardModel: CardModel(id: "0", left: CardSubModel(openText: "Cat", closeText: "Please open left"), right: CardSubModel(openText: "Dog", closeText: "Please open right")))
    }
}
