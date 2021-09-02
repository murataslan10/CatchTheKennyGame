//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Murat Aslan on 12.04.2021.
//

import UIKit

class ViewController: UIViewController {
   
    //Variables (degerler)
    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    //Data
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "score: \(score)" // scorelabel her oyundan sonra degisecek olan score degiskenini atiyoruz "\"
        
        //Highscore check
        let storeHighScore  = UserDefaults.standard.object(forKey: "highScore")
        
        if storeHighScore == nil{
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        if let newscore = storeHighScore as? Int {
            highScore = newscore
            highScoreLabel.text = "Highscore:\(highScore)"
        }
        
        //Images
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        // tiklanabilmeyi aktif hale getiriyor
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
      // 9 resimi tiklanabilir yaptik (UITapGestureREcognizer)
        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        // dokunabililik methodunu butun fotograflara atadim
        
        // image'larin oldugu diziyi olusturduk
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]

        
        //Timer
        counter = 10 // 10dan assagi indiriyoruz
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        // ne yapmak istedigimizi yaziyoruz
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hiddenKenny), userInfo: nil, repeats: true)
        // gizleme timer'i
        
        hiddenKenny()
    }
    
    @objc func hiddenKenny(){             // kenny'leri saklamak icin func olusturduk
        for kenny in kennyArray{  // 9 tane image ayni anda saklamak icin for dongusu kullan.
            kenny.isHidden = true   // ishidden methodu true ile baslatildi
        }
           
        //arc4random_uniform rasgele sayi atmasi, diziler 0 dan baslar o yuzden, count -1 olmasi gerekir
        let random = Int (arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false // kennyArray random bir sayi atayacak, saklayacak ve false basa dondurucek (**for dongusu icindeyiz**)
    }
    
    @objc func increaseScore(){
        score += 1  // her dokundugunda bir artiyor
        scoreLabel.text = "score:\(score)" // score label yazdiriyoruz
        
    }
    
    @objc func countDown() {
        counter -= 1     // counter bir bir indiriyoruz
        timeLabel.text = String(counter)   // counter'i label'a yazdiriyoruz
        
        if counter == 0 {       // counter sifir olursa timer'i durduruyoruz
            timer.invalidate()        // timer durdurmak
            hideTimer.invalidate()       //hidetimer durdurmak yoksa arka palanda calisir
            
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            
            // Highscore
            if self.score > self.highScore {      // h.s buyukse score dan
                self.highScore = self.score    // h.s degistir
                highScoreLabel.text = "Highscore: \(self.highScore)"  // h.s.label'a h.s yaz
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }        //userdefaults.standart.set ile kayit islemi yapiliyor
            
            
        //alert
                // uyari ekrani methodu, ok butonu olusturduk ve replay butonu aksyon butonu
            let alert = UIAlertController(title: "Time's up", message: "Do you want to play?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                // replay func.
                self.score = 0
                self.scoreLabel.text = "Score:\(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                // ne yapmak istedigimizi yaziyoruz
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hiddenKenny), userInfo: nil, repeats: true)
                // gizleme timer'i
             
            }
            
            // tanimlanmis uyarilari 'alert' degiskenine ekliyoruz
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        
        
        }

        
    }
    
    
    
}
            
            
        
        
        
    
    


