//
//  ChoordsViewController.swift
//  appDemo
//
//  Created by Damien on 29/11/2021.
//

import UIKit




class ChoordsViewController: UIViewController, ChoordsLodable, ChoordPickerDelegate  {

    weak var coordinator: AppCoordinator?
    private var viewModel: ChoordsViewModel!
    private var pickerKey : ChoordPicker = ChoordPicker(attribute: ChoordPickerAttribute(font: UIFont(name: "Verdana-Bold", size: 50), itemSize: 70, activeDistance: 10))
    private var pickerChoords : ChoordPicker  = ChoordPicker(attribute: ChoordPickerAttribute(font: UIFont(name: "Verdana-Bold", size: 20), itemSize: 70, activeDistance: 10))
    @IBOutlet  var pickerKeyContainer : UIView!
    @IBOutlet  var pickerChoordsContainer : UIView!
    @IBOutlet  var choordLabel : UILabel!
    @IBOutlet  var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ChoordsViewController.tabName
        pickerKey.pickerDelegate = self
        pickerChoords.pickerDelegate = self
        self.pickerKeyContainer.addSubview(pickerKey)
        pickerKey.bindFrameToSuperviewBounds()
        self.pickerChoordsContainer.addSubview(pickerChoords)
        pickerChoords.bindFrameToSuperviewBounds()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.viewModel.getData()

    }

    private func reloadAll() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            self.pickerKey.reloadData()
            self.pickerChoords.reloadData()
            self.choordPickerDidSelect(picker:  self.pickerKey, index: 0)
        }
    }

    private  func reloadChoordPicker() {
        DispatchQueue.main.async {
            self.pickerChoords.scrollsToTop()
            self.pickerChoords.reloadData()
            self.choordPickerDidSelect(picker: self.pickerChoords, index: 0)
        }
    }

    private func reloadChoordUI(_ choord: Choord) {
        DispatchQueue.main.async {
        self.choordLabel.text = "\(choord.midi) \n\n \(choord.fingers)"
        }
    }

    func setViewModel(_ model : ChoordsViewModel ) {
        self.viewModel = model
        self.viewModel.loadBlock = { [weak self] in
            self?.reloadAll()
        }
        self.viewModel.loadChoordsBlock = {
            [weak self] in
            self?.reloadChoordPicker()
        }
        self.viewModel.loadChoordsDetailsBlock = {[weak self]  choord in
            self?.reloadChoordUI(choord)
        }

        self.viewModel.errorBlock = { [weak self] in
            DispatchQueue.main.async {
                self?.coordinator?.showNetworkAlert()
            }
            }

    }

     func choordPickerNumberIfItems(picker:ChoordPicker) -> Int {
        if picker == pickerKey {
            return  self.viewModel.getKeyCount()
        }
        return self.viewModel.getChoordsCount()
    }

    func choordPickerItemName(picker:ChoordPicker, index: Int ) -> String? {
        if picker == pickerKey {
            return viewModel.keyForIndex(index)?.name
        }
        return viewModel.getChoordNameForIndex(index)
    }

    func choordPickerDidSelect(picker:ChoordPicker, index: Int ) {
        if picker == self.pickerKey {
            self.viewModel.didSelectKeyIndex(index)
            print(viewModel.keyForIndex(index)?.name ?? "undefine")
        } else {
            self.viewModel.didSelectChoordIndex(index)
            print(viewModel.choordForIndex(index)?.suffix ?? "undefine")
        }

    }
}
