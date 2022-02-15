//
//  temperature.swift
//  TemperatureMonitor
//
//  Created by Rodrigo Eduardo Silva on 01/02/22.
//

import Foundation

///
/// Sentor delegate
///
public protocol TemperatureSensorDelegate: AnyObject {
    func sensor(_ sensor: TemperatureSensor, didChange degrees:Int)
}

///
/// Sensor simulator
///
public class TemperatureSensor {
    public weak var delegate: TemperatureSensorDelegate?

    let id: String
    private(set) var temperature: Int = 0
    private var timer: Timer?

    public init(id: String, temperature: Int = 24) {
        self.id = id
        self.temperature = 25
    }

    public func start() {
      guard timer == nil else {
           return }

        timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true, block: { [weak self] _ in
            self?.simulateChange()
                     
            
       })

    }

    private func simulateChange() {
        let value = Int.random(in: 0...99)
        let lowerLimit = 93
        let upperLimit = 97

        if value > upperLimit {
            let difference = value - upperLimit
            self.temperature += difference
            delegate?.sensor(self, didChange: temperature)
            
            return
        }

        if value > lowerLimit {
            let difference = value % 3
            self.temperature -= difference
            delegate?.sensor(self, didChange: temperature)
            
         return
        }
    }
}
