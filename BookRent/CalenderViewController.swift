//
//  CalenderViewController.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/10/1.
//

import UIKit

class CalenderViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    var count = 0
    var smalltap = 0
    var bigtap = 0
    var visited = false
    var store = 0
    var day = 0
    var selectItem: UICollectionViewCell!
    @IBOutlet weak var countDay: UILabel!
    var numberofDayInthisMonth:Int{
        
        let datecomponents = DateComponents(year: CurrentYear,month: CurrentMonth)
        let date = Calendar.current.date(from: datecomponents)!
        let range = Calendar.current.range(of: .day, in: .month, for: date)
        return range?.count ?? 0
    }
    
    
    var whatDayitis:Int{
        let datecomponents = DateComponents(year:CurrentYear,month: CurrentMonth)
        let date = Calendar.current.date(from: datecomponents)!
        return Calendar.current.component(.weekday, from: date)
    }
    var Months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    var CurrentYear = Calendar.current.component(.year, from:Date())
    var CurrentMonth = Calendar.current.component(.month, from: Date())
    
    @IBAction func lastMonth(_ sender: Any) {
        
        
        CurrentMonth -= 1
        if CurrentMonth == 0{
            CurrentMonth = 12
            CurrentYear -= 1
        }
        setup()
        cal.reloadData()
        
        
    }
    @IBAction func nextMonth(_ sender: Any) {
        CurrentMonth += 1
        if CurrentMonth == 13{
            CurrentYear += 1
            CurrentMonth = 1
        }
        setup()
    }
    @IBOutlet weak var YearMonth: UILabel!
    @IBOutlet weak var cal: UICollectionView!
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberofDayInthisMonth + (whatDayitis - 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let reusecell = collectionView.dequeueReusableCell(withReuseIdentifier: "Reusecell", for: indexPath)
        if let textLabel = reusecell.contentView.subviews[0] as? UILabel{
            if indexPath.row < (whatDayitis-1){
                textLabel.text = ""
            }else{
            textLabel.text = "\(indexPath.row+1 - (whatDayitis-1))"
        }
    }
        return reusecell
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width) / 7
        
        return CGSize(width:width, height:20.5)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectItem = collectionView.cellForItem(at: indexPath)!
        
        var tap = indexPath.row
        count += 1
        if count == 1{
            smalltap = tap
            selectItem.backgroundColor = UIColor.gray
        }else {
            if visited == false{
            if tap < smalltap{
                store = smalltap
                smalltap = tap
                tap = store
                day = tap - smalltap+1
                for i in smalltap...tap{
                    selectItem = collectionView.cellForItem(at: [0,i])!
                    selectItem.backgroundColor = UIColor.gray
                }
                count = 1
                bigtap = tap
                countDay.text = String(day)
            }else{
                day = tap - smalltap+1
                for i in smalltap...tap{
                    selectItem = collectionView.cellForItem(at: [0,i])!
                    selectItem.backgroundColor = UIColor.gray
                }
                count = 1
                bigtap = tap
                countDay.text = String(day)
            }
                visited = true
            }else{
                
                if tap < smalltap{
                    store = smalltap
                    smalltap = tap
                    tap = store
                    day = tap - smalltap+1
                    for i in smalltap...tap{
                        selectItem = collectionView.cellForItem(at: [0,i])!
                        selectItem.backgroundColor = UIColor.gray
                    }
                    for i in tap+1...bigtap{
                        selectItem = collectionView.cellForItem(at: [0,i])!
                        selectItem.backgroundColor = .clear
                    }
                    bigtap = tap
                    countDay.text = String(day)
                    count = 1
                    
                }else if (tap > bigtap){
                    store = bigtap
                    bigtap = tap
                    tap = store
                    
                    
                    day = bigtap - tap + 1
                    for i in tap...bigtap{
                        selectItem = collectionView.cellForItem(at: [0,i])!
                        selectItem.backgroundColor = UIColor.gray
                    }
                    for i in smalltap...tap-1{
                        selectItem = collectionView.cellForItem(at: [0,i])!
                        selectItem.backgroundColor = .clear
                    }
                    smalltap = tap
                    countDay.text = String(day)
                    count = 1
                    
                }else if (smalltap < tap) && (tap < bigtap){
                    day = tap - smalltap + 1
                    for i in smalltap...tap{
                        selectItem = collectionView.cellForItem(at: [0,i])!
                        selectItem.backgroundColor = UIColor.gray
                    }
                    for i in tap+1...bigtap{
                        selectItem = collectionView.cellForItem(at: [0,i])!
                        selectItem.backgroundColor = .clear
                    }
                    countDay.text = String(day)
                    count = 1
                }
            }
        }
        print("smalltap",smalltap)
        print("bigtap",bigtap)
        print("tap",tap)
        
}
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        setup()
        // Do any additional setup after loading the view.
    }
    

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        cal.collectionViewLayout.invalidateLayout()
        cal.reloadData()
    }
    
    
    func setup(){
        
        
        YearMonth.text = Months[CurrentMonth - 1] + "\(CurrentYear)"
        cal.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
