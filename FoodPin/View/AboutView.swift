//
//  AboutView.swift
//  FoodPin
//
//  Created by Simon Ng on 4/11/2025.
//

import SwiftUI
import WebKit

struct AboutView: View {
    
    enum WebLink: String, Identifiable {
        case rateUs = "https://www.apple.com/ios/app-store"
        case feedback = "https://www.appcoda.com/contact"
        case twitter = "https://www.x.com/appcodamobile"
        case facebook = "https://www.facebook.com/appcodamobile"
        case instagram = "https://www.instagram.com/appcodadotcom"
        
        var id: UUID {
            UUID()
        }
    }
    
    @State private var link: WebLink?
    
    var body: some View {
        NavigationStack {
            List {
                Image("about")
                    .resizable()
                    .scaledToFit()
                
                Section {
                    Label("Rate us on App Store", image: "store")
                        .onTapGesture {
                            link = .rateUs
                        }
                        
                    Label("Tell us your feedback", image: "chat")
                        .onTapGesture {
                            link = .feedback
                        }
                }
                
                Section {
                    Label {
                        Text("X")
                    } icon: {
                        Image("twitter").resizable()
                    }
                    .onTapGesture {
                        link = .twitter
                    }
                    
                    Label("Facebook", image: "facebook")
                        .onTapGesture {
                            link = .facebook
                        }
                    
                    Label("Instagram", image: "instagram")
                        .onTapGesture {
                            link = .instagram
                        }
                }
            }
            .listStyle(.grouped)
            
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.automatic)
        }
        .sheet(item: $link) { item in
            WebView(url: URL(string: item.rawValue))
        }
    }
}

#Preview {
    AboutView()
}
