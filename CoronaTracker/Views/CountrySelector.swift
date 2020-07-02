//
//  CountrySelector.swift
//  CoronaTracker
//
//  Created by Munish Sehdev on 2020-07-01.
//  Copyright © 2020 Munish Sehdev. All rights reserved.
//

import SwiftUI

struct CountrySelector: View {
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")

                        TextField("search", text: $searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            print("onCommit")
                        }).foregroundColor(.primary)

                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)

                    if showCancelButton  {
                        Button("Cancel") {
                            self.searchText = ""
                            self.showCancelButton = false
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                .padding(.horizontal)
                .navigationBarHidden(showCancelButton)// .animation(.default) // animation does not work properly

                List {
                    ForEach(0..<5) { _ in
                        HStack(spacing: 30) {
                            ForEach(0..<3) { _ in
                                VStack {
                                    Image(systemName: "globe")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: (UIScreen.screenWidth - 100) / 3, height: (UIScreen.screenWidth - 100) / 3)
                                    Text("yo")
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Search"))
        }
    }
}

struct CountrySelector_Previews: PreviewProvider {
    static var previews: some View {
        CountrySelector()
    }
}
