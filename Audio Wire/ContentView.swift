//
//  ContentView.swift
//  Audio Wire
//
//  Created by Иван Дахненко on 03.01.2020.
//  Copyright © 2020 Ivan Dakhnenko. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedView = 0
    @State var message = ""
    @State var TC = TransmissionController()
    @State var AR = AudioRecognizer.sharedRecognizer()
    //@State var receivedMessage = AudioRecognizer.sharedRecognizer().recognizerStream
        
    var body: some View {
        TabView(selection: $selectedView) {
            // =============== Tab 1 : send ===============
            HStack {
                //TextField(text: $message)
                TextField("Message", text: $message)
                Button(action: {
                    self.TC.send(message: self.message)
                    self.message = ""
                }) {
                    Text("Send")
                }
            }
            .padding()
            .tabItem {
                Image(systemName: "arrow.up")
                Text("Send")
            }
            .tag(0)
            
            // =============== Tab 2 : receive ===============
            VStack {
                Text("Received stream")
                    .font(.headline)
                Button(action: {
                    self.AR.startRecognition()
                }) {
                    Text("Start")
                }
                Divider()
                TextField("Message", text: $AR.recognizerStream)
                //TODO: call stream update form UI thread,
                // as it does not updates implicitly.
            }
            .padding()
            .tabItem {
                Image(systemName: "arrow.down")
                Text("Receive")
            }
            .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(selectedView: 0).environment(\.colorScheme, .dark)
            ContentView(selectedView: 1).environment(\.colorScheme, .dark)
        }
    }
}
