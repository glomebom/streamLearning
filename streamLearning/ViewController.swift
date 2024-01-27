//
//  ViewController.swift
//  streamLearning
//
//  Created by Gleb on 27.01.2024.
//

//Создайте новый проект и напишите в нём функцию downloadLargeFile(), которая:
//загружает большой гипотетический файл асинхронно;
//обновляет прогресс-бар после каждых 25% прогресса;
//показывает оповещение, когда загрузка завершается.
//Тестовые случаи:
//Вызовите downloadLargeFile() и проверьте обновление прогресс-бара.
//Добавьте замыкание к downloadLargeFile() и проверьте показ оповещения.

import UIKit

struct Progress {
    var progress: Float
    
    init(progress: Float) {
        self.progress = progress
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var startDownload: UIButton!
    @IBOutlet weak var stopDownload: UIButton!
    @IBOutlet weak var progressBarView: UIProgressView!
    
    var progressBar: Progress = Progress(progress: 0.0)
    var workItem : DispatchWorkItem?
    var workItemAlert : DispatchWorkItem?
    
    var stopWorkClick : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressBarView.setProgress(0.0, animated: false)
    }
    
    
    @IBAction func startWork(_ sender: Any) {
        print("Нажата кнопка загрузки")
        self.progressBarView.setProgress(0.0, animated: false)
        stopWorkClick = false
        downloadLargeFile()
    }
    
    @IBAction func stopWork(_ sender: Any) {
        print("Нажата кнопка остановки")
//        self.workItem?.cancel()
//        self.workItem?.self.cancel()
        stopWorkClick = true
    }

    private func downloadLargeFile() {
        
        workItem = DispatchWorkItem {
            for i in 1...10 {
                if self.stopWorkClick {
                    return
                }
                self.progressBar.progress = Float(i)/10
                DispatchQueue.main.async {
                    self.progressBarView.setProgress(self.progressBar.progress, animated: true)
                }
                print("\(self.progressBar.progress)")
                sleep(2)
            }
            DispatchQueue.main.async(execute: self.workItemAlert!)
        }
        
        workItemAlert = DispatchWorkItem {
            let alert = UIAlertController(title: "Готово!", message: "Файл загружен", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        DispatchQueue.global().async(execute: workItem!)
        
    }
    
    //        DispatchQueue.global().async(){
    //            for i in 1...4 {
    //                DispatchQueue.main.async {
    //                    self.progressBar.progress = Float(i)/4
    //                    print("\(self.progressBar.progress)")
    //                }
    //                sleep(1)
    //            }
    //
    //            DispatchQueue.main.async {
    //                let alert = UIAlertController(title: "Готово!", message: "Файл загружен", preferredStyle: .alert)
    //                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    //                self.present(alert, animated: true, completion: nil)
    //            }
    //        }
}
