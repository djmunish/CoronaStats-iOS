//
//  ProgressBar.swift
//  CoronaTracker
//
//  Created by Munish Sehdev on 2020-07-12.
//  Copyright © 2020 Munish Sehdev. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    @State var countryResult: ResultModel

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(countryResult.bgColor)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.countryResult.resultPercentage, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(countryResult.bgColor)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)

            Text(String(format: "%.0f %%", min(self.countryResult.resultPercentage, 1.0)*100.0))
                .font(.largeTitle)
                .bold()
        }
    }
}

//struct ProgressBar_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressBar(progress: 1.0)
//    }
//}
