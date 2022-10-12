//
//  ViewController.swift
//  MAwalkHolic
//
//  Created by yangjs on 2022/10/06.
//

import UIKit
import Charts
import HealthKit

class StepModel: NSObject {
    var step: Double = 0.0
    var date: Date = Date()
    override init() {
        super.init()
    }
    convenience init(step: Double, date: Date) {
        self.init()
        self.step = step
        self.date = date
    }
}
class MainController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.stepList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let size = self.stepList.count-1
        let stepinfo = self.stepList[size-indexPath.row]
        
        cell.textLabel?.text = stepinfo.date.toString()
        cell.detailTextLabel?.text = "\(Int(stepinfo.step)) 보"
        return cell
    }
    
    let healthStore = HKHealthStore()
    let axisValues = ["D-6","D-5","D-4","D-3","D-2","D-1","오늘"]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chartView: BarChartView!
    let typeToShare = HKQuantityType.quantityType(forIdentifier: .stepCount)
    let typeToRead = HKQuantityType.quantityType(forIdentifier: .stepCount)
    
    var stepDataList : [String] = []
    var stepList : [StepModel] = [StepModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configure()
        
        tableView.dataSource = self
        self.title = "워커홀릭"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("printViewwillAeppear")
        setHealthData()
    }
    
    func configure(){
        print("configure")
        if HKHealthStore.isHealthDataAvailable(){
            requestAuthorization()

        }
        //setHealthData()
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        setHealthData()
    }
    func requestAuthorization(){
        self.healthStore.requestAuthorization(toShare: Set([typeToShare!]), read: Set([typeToRead!])) { success, error in
            if success{
                print("권한 승인 완료")
                self.setHealthData()
            }else{
                print(error?.localizedDescription ?? "권산 승인 실패")
            }
         
        }
    }
    
    func setHealthData() {
        print("retrieveData")
        let calender = Calendar.current
        var interval = DateComponents()
        interval.day = 1
        
        var anchorComponents = calender.dateComponents([.day, .month, .year], from: NSDate() as Date)
        anchorComponents.hour = 0
        let anchorDate = calender.date(from: anchorComponents)
        
        let stepQuery = HKStatisticsCollectionQuery(quantityType: HKObjectType.quantityType(forIdentifier: .stepCount)!, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: anchorDate!, intervalComponents: interval as DateComponents)
        stepQuery.initialResultsHandler = { query, results, error in
            let endDate = NSDate()
            // 오늘로부터 30일간의 걸음수 데이터를 가져오도록 진행
            let startDate = calender.date(byAdding: .day, value: -30, to: endDate as Date, wrappingComponents: false)
            if let myResults = results {
                myResults.enumerateStatistics(from: startDate!, to: endDate as Date) { statistics, stop in
                    if let quantity = statistics.sumQuantity() {
                        let date = statistics.startDate
                        let steps = quantity.doubleValue(for: HKUnit.count())
                        self.stepDataList.append("\(date): \(steps)")
                        let model = StepModel(step: steps, date: date)
                        print(self.stepDataList.last)
                        self.stepList.append(model)
                        
                    }
                }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else{
                        return
                    }
                    
                    var tmp  = [BarChartDataEntry]()
                    var cnt = 0
                    for i in (self.stepList.count-7..<self.stepList.count){
                        tmp.append(BarChartDataEntry(x: Double(cnt), y: self.stepList[i].step))
                        cnt+=1
                    }
                    print(tmp)
                    let chartDataSet = BarChartDataSet(entries: tmp, label: "걷기")
                    chartDataSet.colors = [.systemPink]
                    
                    let chartData = BarChartData(dataSet: chartDataSet)
                    self.chartView.data = chartData
                    // 선택 안되게
                    chartDataSet.highlightEnabled = false
                    // 줌 안되게
                    self.chartView.doubleTapToZoomEnabled = false
                    
                    print(self.chartView.xAxis.labelCount)
                    self.chartView.xAxis.labelPosition = .bottom
                    self.chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:self.axisValues)
                    
                    let minimumRecord = ChartLimitLine(limit: 7000.0, label: "7000보")
                    
                    
                    self.chartView.leftAxis.addLimitLine(minimumRecord)
                    self.chartView.leftAxis.axisMinimum = 0
                    self.tableView.reloadData()
                }
            }
        }
        healthStore.execute(stepQuery)
    }
    func showInfo(){
        
    }
    func saveStepCount(stepValue: Int, date: Date, completion: @escaping (Error?) -> Void) {
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        let stepCountUnit: HKUnit = HKUnit.count()
        let stepCountQuantity = HKQuantity(unit: stepCountUnit, doubleValue: Double(stepValue))
        
        let stepCountSample = HKQuantitySample(type: stepCountType, quantity: stepCountQuantity, start: date, end: date)
        
        self.healthStore.save(stepCountSample) { (success, error) in
            if let error = error {
                completion(error)
                print("Error Saving Steps count Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saves step count sample")
            }
        }
    }
    //get post delete put
    
    
}

