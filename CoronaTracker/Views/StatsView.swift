//
//  StatsView.swift
//  CoronaTracker
//
//  Created by Munish Sehdev on 2020-06-30.
//  Copyright © 2020 Munish Sehdev. All rights reserved.
//

import SwiftUI

struct StatsView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Group {
                Image(systemName: "flag.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                Spacer().frame(height: -20)
                Text("India")
                    .bold()
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .foregroundColor(.black)
                    .cornerRadius(5.0)
                Spacer().frame(height: 5)
                Text("Active Cases \n \(2000000)")
                    .bold()
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.horizontal, 90)
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20.0)
                Spacer().frame(height: 5)
                Text("Deaths \n \(2000000)")
                    .bold()
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.horizontal, 100)
                    .padding(.bottom, 10)
                    .padding(.top, 10)                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(20.0)
                Spacer().frame(height: 5)
                Text("Recoveries \n \(2000000)")
                    .bold()
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.horizontal, 100)
                    .padding(.bottom, 10)
                    .padding(.top, 10)                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(20.0)
                Spacer().frame(height: 5)
            }
            Group {
                HStack {
                    Text("Last Updated:")
                        .bold()
                        .foregroundColor(.secondary)
                    Button(action: {
                        print("Refresh!!")
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .frame(width: 44, height: 44)
                    }
                }
            }
            Spacer()
                .frame(height: 10)
            Group {
                Button(action: {
                    print("clicked!!")
                }) {
                    Image(systemName: "globe")
                        .foregroundColor(.red)
                        .font(.largeTitle)
                        .frame(width: 44, height: 44)
                }
            }
        }
        .padding()
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
