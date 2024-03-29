//
//  Chart.swift
//  CrytoX
//
//  Created by junemp on 2022/06/06.
//

import SwiftUI

struct Chart: View {
    
    let dataSet: [DataEntry]
    
    var body: some View {
//        MySquare().frame(width: 250, height: 250)
        ZStack(alignment: .trailing) {
            if !dataSet.isEmpty {
                Grid()
                    .stroke(lineWidth: 0.2)
    //            Graph(dataSet: dataSet)
    //                .stroke(lineWidth: 2.0)
                GraphGradient(dataSet: dataSet)
                    .fill(LinearGradient(gradient: bullishBearishGradient(lastClose: dataSet.last?.close ?? 0, firstClose: dataSet.first?.close ?? 0), startPoint: .top, endPoint: .bottom))
                PriceLegend(dataSet: dataSet)
            }
        }
        
    }
}

struct MySquare: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.size.width, y: 0))
        path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.width))
        path.addLine(to: CGPoint(x: 0, y: rect.size.width))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.closeSubpath()
        
        print(rect)
        
        return path
    }
}

struct Grid: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // 세로줄
        path.move(to: CGPoint(x: rect.size.width*0.25, y: 0))
        path.addLine(to: CGPoint(x: rect.size.width*0.25, y: rect.size.height))
        
        path.move(to: CGPoint(x: rect.size.width*0.5, y: 0))
        path.addLine(to: CGPoint(x: rect.size.width*0.5, y: rect.size.height))
        
        path.move(to: CGPoint(x: rect.size.width*0.75, y: 0))
        path.addLine(to: CGPoint(x: rect.size.width*0.75, y: rect.size.height))
        
        // 가로줄
        path.move(to: CGPoint(x: 0, y: rect.size.height*0.25))
        path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height*0.25))
        
        path.move(to: CGPoint(x: 0, y: rect.size.height*0.5))
        path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height*0.5))
        
        path.move(to: CGPoint(x: 0, y: rect.size.height*0.75))
        path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height*0.75))
        
        return path
    }
    
    
}

struct Graph: Shape {
    
    let dataSet: [DataEntry]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let max = dataSet.map { $0.close }.max()
        let min = dataSet.map { $0.close }.min()
        
        let startingPoint = CGPoint(x: 0, y:
                                        (
                                            1 -
                                            (CGFloat(dataSet[0].close - (min ?? 0))) / (CGFloat((max ?? 0) - (min ?? 0)))
                                        ) * rect.size.height
                                    )
        
        path.move(to: startingPoint)
        
        for (index, entry) in dataSet.enumerated() {
            let xValue = rect.size.width * CGFloat(Double(index) / Double(dataSet.count-1))
            let yValue = (
                            1 -
                            (CGFloat(entry.close - (min ?? 0))) / (CGFloat((max ?? 0) - (min ?? 0)))
                         ) * rect.size.height
            path.addLine(to: CGPoint(x: xValue, y: yValue))
        }
        
        return path
    }
}

struct GraphGradient: Shape {
    
    let dataSet: [DataEntry]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let max = dataSet.map { $0.close }.max()
        let min = dataSet.map { $0.close }.min()
        
        let startingPoint = CGPoint(x: 0, y:
                                        (
                                            1 -
                                            (CGFloat(dataSet[0].close - (min ?? 0))) / (CGFloat((max ?? 0) - (min ?? 0)))
                                        ) * rect.size.height
                                    )
        
        path.move(to: startingPoint)
        
        for (index, entry) in dataSet.enumerated() {
            let xValue = rect.size.width * CGFloat(Double(index) / Double(dataSet.count-1))
            let yValue = (
                            1 -
                            (CGFloat(entry.close - (min ?? 0))) / (CGFloat((max ?? 0) - (min ?? 0)))
                         ) * rect.size.height
            path.addLine(to: CGPoint(x: xValue, y: yValue))
        }
        
        path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height))
        path.addLine(to: CGPoint(x: 0, y: rect.size.height))
        path.closeSubpath()
        
        return path
    }
}

struct PriceLegend: View {
    
    let dataSet: [DataEntry]
    let min: Double
    let max: Double
    
    init(dataSet: [DataEntry]) {
        self.dataSet = dataSet
        min = dataSet.map { $0.close }.min() ?? 0
        max = dataSet.map { $0.close }.max() ?? 0
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(String(format: "%.2f", (max-min)*0.75+min))
                .font(.custom("Avenir", size: 14))
                .foregroundColor(.gray)
            Spacer()
            Text(String(format: "%.2f", (max-min)*0.5+min))
                .font(.custom("Avenir", size: 14))
                .foregroundColor(.gray)
            Spacer()
            Text(String(format: "%.2f", (max-min)*0.25+min))
                .font(.custom("Avenir", size: 14))
                .foregroundColor(.gray)
            Spacer()
            Text(String(format: "%.2f", min))
                .font(.custom("Avenir", size: 14))
                .foregroundColor(.gray)
            
        }
    }
}

struct Chart_Previews: PreviewProvider {
    static var previews: some View {
        Chart(dataSet: sampleData)
            .frame(height: 300)
    }
}
