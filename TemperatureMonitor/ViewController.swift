//
//  ViewController.swift
//  TemperatureMonitor
//
//  Created by Rodrigo Eduardo Silva on 01/02/22.
//

import UIKit

class ViewController: UIViewController {

    
   
  
    var sensors: [TemperatureSensor] = []

    @IBOutlet var tempLabel: [UILabel]!
    
    @IBOutlet var TempBar: [UIProgressView]!
    
     override func viewDidLoad() {
         
         
         
        
    updatebar()
   }
    
    func barProgress(idSensor: String ,degrees : Int){
        var barindex: Int = 0
        switch idSensor{
        case "Sensor 001":
            barindex = 0
        case "Sensor 002":
            barindex = 1
        case "Sensor 003":
            barindex = 2
        case "Sensor 004":
            barindex = 3
        default:
            barindex = 3
        }
        

        TempBar[barindex].setProgress(Float(degrees)/40, animated: true)
        tempLabel[barindex].text = "\(Int(degrees))℃"

    }
  
    func updatebar(){
       
       let sensorlist = [TemperatureSensor(id: "Sensor 001"),
                         TemperatureSensor(id: "Sensor 002"),
                         TemperatureSensor(id: "Sensor 003"),
                         TemperatureSensor(id: "Sensor 004"),
                                                                ]
      
        
        let monitor = ViewController()
        
        let timer : Timer?
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true, block: { [weak self] _ in

        for sensor in sensorlist {
            
            sensor.delegate = self
            monitor.add(sensor: sensor)

        }
        })
                
    }
     func add(sensor: TemperatureSensor) {
        
        self.sensors.append(sensor)
        sensor.start()
        
     }
    
}


  
extension ViewController : TemperatureSensorDelegate{
    func sensor(_ sensor: TemperatureSensor, didChange degrees: Int) {
        print("- Sendor \(sensor.id) - mudou para \(degrees)")
        barProgress(idSensor: sensor.id, degrees: degrees)
       
    }

}




