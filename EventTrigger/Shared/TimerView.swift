//
//  TimerView.swift
//  EventTrigger
//
//  Created by Kim, Min Ho on 2021/07/24.
//

import SwiftUI

struct TimerView: View {
    @State var isTimerRunning = false
    @State private var startTime =  Date()
    @State private var timerString = "0.0"
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {

        Text(timerString)
            .font(Font.system(.largeTitle, design: .monospaced))
            .onReceive(timer) { _ in
                if isTimerRunning {
                    timerString = String(format: "%.1f", (Date().timeIntervalSince(startTime)))
                }
            }
            .onTapGesture {
                if isTimerRunning {
                    // stop UI updates
                    stopTimer()
                } else {
                    timerString = "0.00"
                    startTime = Date()
                    // start UI updates
                    startTimer()
                }
                isTimerRunning.toggle()
            }
            .onAppear() {
                // no need for UI updates at startup
                stopTimer()
            }
    }
    
    func stopTimer() {
        timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    }
}
