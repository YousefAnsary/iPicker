//
//  IFullDataPicker.swift
//  IPicker
//
//  Created by Yousef on 1/9/21.
//  Copyright © 2021 Yousef. All rights reserved.
//

import UIKit

public extension IPicker {
class FullViewPicker: UIView, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Variables
    private let style: IPicker.Style
    private var blurStyle: UIBlurEffect.Style!
    private var textColor: UIColor!
    
    public var selectedIndex = 0
    private (set) internal var  strings: [String]
    private var didSelect: ((Int)-> Void)?
    private var didCancelled: (()-> Void)?
    
    //MARK: - Views
    private lazy var blurEffect: UIBlurEffect = {
        let blurEffect = UIBlurEffect(style: blurStyle)
        return blurEffect
    }()
    
    internal lazy var blurEffectView: UIVisualEffectView = {
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.backgroundColor = .clear
        tv.showsVerticalScrollIndicator = false
        tv.separatorStyle = .none
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 110, right: 0)
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 20
        stack.addArrangedSubview(doneButton)
        stack.addArrangedSubview(closeButton)
        return stack
    }()
    
    internal lazy var doneButton: UIButton = {
        let btn = UIButton()
        btn.isHidden = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn.layer.cornerRadius = 22.5
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowRadius = 20
        btn.setTitle("", for: .normal)
        let image = UIImage(named: "ok", in: Bundle(for: type(of: self)), compatibleWith: nil)?.maskWithColor(color: .white)
        btn.setImage(image, for: .normal)
        btn.contentMode = .scaleToFill
        btn.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    internal lazy var closeButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 45).isActive = true
        btn.layer.cornerRadius = 22.5
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowRadius = 20
        btn.setTitle("", for: .normal)
        let image = UIImage(named: "close", in: Bundle(for: type(of: self)), compatibleWith: nil)?.maskWithColor(color: .white)
        btn.setImage(image, for: .normal)
        btn.contentMode = .scaleToFill
        btn.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    
    
    public init(style: IPicker.Style) {
        self.style = style
        strings = []
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleStyles(parent: UIView) {
        switch style {
        case .dark:
            blurStyle = .dark
            textColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        case .light:
            blurStyle = .light
            textColor = #colorLiteral(red: 0, green: 0, blue: 0.07843137255, alpha: 0.8487264555)
        case .autoLight, .autoDark:
            if #available(iOS 12.0, *) {
                let userInterfaceStyle = parent.traitCollection.userInterfaceStyle
                blurStyle =  userInterfaceStyle == .dark ? .dark : .light
                textColor = userInterfaceStyle == .dark ? #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0.07843137255, alpha: 0.8487264555)
            } else {
                if case .autoLight = style {
                    blurStyle = .light
                    textColor = #colorLiteral(red: 0, green: 0, blue: 0.07843137255, alpha: 0.8487264555)
                } else {
                    blurStyle = .dark
                    textColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                }
            }
        }
    }
    
    func setupView(parent: UIView) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.alpha = 0
        
        handleStyles(parent: parent)
        
        parent.addSubview(self)
        self.constraintTop(to: parent.safeAreaLayoutGuide.topAnchor, constant: 0)
        self.constraintBottom(to: parent.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        self.constraintLeading(to: parent.safeAreaLayoutGuide.leadingAnchor, constant: 0)
        self.constraintTrailing(to: parent.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        
        self.addSubview(blurEffectView)
        blurEffectView.contentView.addSubview(tableView)
        
        let parentHeight = parent.frame.height - parent.safeAreaInsets.top
        tableView.isScrollEnabled = (Int(parentHeight) - 50) < (strings.count * 50)
        tableView.constraintCenterX(to: self.centerXAnchor, constant: 0)
        tableView.constraintCenterY(to: self.centerYAnchor, constant: 0)
        let tableHeight = min(strings.count * 50, Int(parentHeight) - 50)
        tableView.heightAnchor.constraint(equalToConstant: CGFloat(tableHeight)).isActive = true
        tableView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
        
        self.addSubview(buttonsStack)
        buttonsStack.constraintCenterX(to: self.centerXAnchor, constant: 0)
        buttonsStack.constraintBottom(to: self.bottomAnchor, constant: -50)
        
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1
        }
        
    }
    
    @objc private func closeButtonTapped() {
        UIView.animate(withDuration: 0.2, animations: {
            self.closeButton.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.closeButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: { _ in
                self.didCancelled?()
                self.dismiss()
            })
        }
    }
    
    @objc internal func doneButtonTapped() {
        UIView.animate(withDuration: 0.2, animations: {
            self.closeButton.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.closeButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: { _ in
                self.dismiss()
            })
        }
    }
    
    public func setData<T>(data: [T], key: KeyPath<T, String>) {
        self.setData(data: data.map{ $0[keyPath: key] })
    }
    
    public func setData(data: [String]) {
        self.strings = data
        self.tableView.reloadData()
    }
    
    public func show(in view: UIView) {
        self.setupView(parent: view)
    }
    
    public func didSelect(_ block: @escaping (Int)-> Void) {
        self.didSelect = block
    }
    
    public func didCancelled(_ completion: @escaping ()-> Void) {
        self.didCancelled = completion
    }
    
    public func dismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strings.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        setupCell(cell!, indexPath: indexPath)
        if self.selectedIndex == indexPath.row {
            animateCellSelection(cell: cell!)
        } else {
            animateCellDeselection(cell: cell!)
        }
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previousSelectedIndex = self.selectedIndex
        self.selectedIndex = indexPath.row
        let indexesToReload = previousSelectedIndex == -1 ? [indexPath] : [indexPath, IndexPath(row: previousSelectedIndex, section: 0)]
        tableView.reloadRows(at: indexesToReload, with: .automatic)
        didSelect?(self.selectedIndex)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss()
        }
    }
    
    internal func setupCell(_ cell: UITableViewCell!, indexPath: IndexPath) {
        cell.backgroundColor = .clear
        cell.textLabel?.textAlignment = .center
        cell.selectionStyle = .none
        cell.textLabel?.text = strings[indexPath.row]
    }
    
    internal func animateCellSelection(cell: UITableViewCell) {
        UIView.animate(withDuration: 0.5) {
            cell.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            cell.textLabel?.textColor = self.textColor
        }
    }
    
    internal func animateCellDeselection(cell: UITableViewCell) {
        UIView.animate(withDuration: 0.5) {
            cell.transform = .identity
            cell.textLabel?.textColor = self.textColor.withAlphaComponent(0.8)
        }
    }
    
}
}
