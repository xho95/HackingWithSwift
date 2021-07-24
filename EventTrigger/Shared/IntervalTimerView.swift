//
//  IntervalTimer.swift
//  EventTrigger
//
//  Created by Kim, Min Ho on 2021/07/24.
//

import SwiftUI

struct IntervalTimerView: View {
    @State private var timeInterval = TimeInterval()
    @State private var currentInterval = TimeInterval()

    @State var isTimerRunning = false
    @State private var startTime =  Date()
    @State private var timerString = "0.0"
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text(timerString)
                .font(Font.system(.largeTitle, design: .monospaced))
                .onReceive(timer) { _ in
                    if isTimerRunning {
                        timeInterval = currentInterval + Date().timeIntervalSince(startTime)
                        timerString = String(format: "%.1f", timeInterval)
                    }
                }
                .onTapGesture {
                    if isTimerRunning {
                        print("timeInterval: \(timeInterval)")
                        currentInterval = timeInterval
                        stopTimer()
                    } else {
                        //timerString = "0.00"
                        print("currentInterval: \(currentInterval)")
                        startTime = Date()
                        startTimer()
                    }
                    isTimerRunning.toggle()
                }
                .onAppear() {
                    stopTimer()
                }
            
            Button {
                startTimer()
            } label: {
                Text("Start")
            }
            
            Button {
                stopTimer()
            } label: {
                Text("Stop")
            }
        }
    }
    
    func stopTimer() {
        timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    }
}
