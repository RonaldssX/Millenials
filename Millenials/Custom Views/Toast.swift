//
//  Toast.swift
//  Millenials
//
//  Created by Ronaldo Santana on 24/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import UIKit
import ObjectiveC

struct ToastData {
    
    /// Create a new ToastData with default values
    init() {
        self.cornerRadius = 10.0
        self.backgroundColor = .OffBlack
        
        self.labelFont = .defaultFont(size: 15, weight: .medium)
        self.labelTextColor = .OffWhite
        self.labelBackgroundColor = .clear
        self.labelText = "Toast!"
        self.labelTextAlignment = .center
        self.labelLineBreakMode = .byWordWrapping
        
        self.duration = 3
    }
    
    var cornerRadius: CGFloat
    var backgroundColor: UIColor
    
    var labelFont: UIFont
    var labelTextColor: UIColor
    var labelBackgroundColor: UIColor
    var labelText: String
    var labelTextAlignment: NSTextAlignment
    var labelLineBreakMode: NSLineBreakMode
    
    var duration: TimeInterval
    
    weak var delegate: ToastDelegate?
    
}

@objc
protocol ToastDelegate {
    
    @objc optional func toast(_ toast: ToastView, willPresent atView: UIView?)
    @objc optional func toast(_ toast: ToastView, didPresent atView: UIView?)
    @objc optional func toast(_ toast: ToastView, hasStartedTimer timer: Timer?)
    @objc optional func toast(_ toast: ToastView, hasStartedExitAnimation atView: UIView?)
    @objc optional func toast(_ toast: ToastView, hasEndedExitAnimation atView: UIView?)
    @objc optional func toast(_ toast: ToastView, hasFiredTimer timer: Timer?)
    
}

final class ToastPresentViewController: UIViewController, UIViewControllerAnimatedTransitioning {
    
    var toastView: ToastView!
    
    init(toast: ToastView) {
        self.toastView = toast
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .clear
        view.addSubview(toastView)
        NSLayoutConstraint.activate([
            toastView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toastView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toastView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            toastView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        toastView.removeFromSuperview()
        toastView = nil
    }
    
    func configure(toast: ToastView) {
        self.toastView = toast
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning conforms
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
        
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromScene = transitionContext.viewController(forKey: .from),
                let toScene = transitionContext.viewController(forKey: .to) as? ToastPresentViewController else { return }
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toScene.toastView)
        
    }
    
    
}

final class Toast {
    
    fileprivate static let shared: Toast = Toast()
    private var isQueueEnabled: Bool = true
    private var queue: [ToastView] = []
    private var currentToast: ToastView? {
        didSet {
            if currentToast == nil && !queue.isEmpty {
                TryToPresentToast(queue.first!)
            }
        }
    }
    
    required init() {
        NotificationCenter.default.addObserver(self, selector: #selector(clearCurrentToast), name: notification(name: "toastEnded"), object: nil)
    }
    
    static func getToast(with message: String, data: ToastData? = nil) -> ToastView {
        var toastData: ToastData = data ?? ToastData()
        toastData.labelText = message
        let toastView = ToastView()
        toastView.configureWith(data: toastData)
        return toastView
    }
    
    static func toast(with message: String, data: ToastData? = nil) {
        let toast = getToast(with: message, data: data)
        Toast.shared.TryToPresentToast(toast)
    }
    
    private func TryToPresentToast(_ toast: ToastView) {
        if isQueueEnabled && !queue.isEmpty {
            queue.append(toast)
        } else {
            presentToast(toast)
        }
        
    }
    
    private func presentToast(_ toast: ToastView) {
        return present(toast)

    }
    
    private func present(_ toast: ToastView) {
        let toastController = ToastPresentViewController(toast: toast)
        if let controller = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            controller.modalPresentationStyle = .formSheet
            controller.present(toastController, animated: true)
        }
    }
    
    @objc private func clearCurrentToast() {
        currentToast = nil
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

@objc
final class ToastView: UIView {
   
    private lazy var id: Int = Int.random(in: Int.min...Int.max)
    var data: ToastData!
    private var timer: Timer?
    
    var delegate: ToastDelegate? {
        get { data?.delegate }
    }

    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = data.backgroundColor
        view.layer.cornerRadius = data.cornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = data.labelBackgroundColor
        label.numberOfLines = 3
        label.font = data.labelFont
        label.text = data.labelText
        label.textColor = data.labelTextColor
        label.textAlignment = data.labelTextAlignment
        label.lineBreakMode = data.labelLineBreakMode
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func configureWith(data: ToastData) {
        self.data = data
        setupView()
    }
    
}

extension ToastView {
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        setupHierarchy()
        setupConstraints()
        configureView()
    }
    
    private func setupHierarchy() {
        addSubview(contentView)
        contentView.addSubview(label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            
            heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    func configureView() {
        autoresizingMask = [.flexibleHeight]
    }
    
    @objc func animateEntrance() {
        delegate?.toast?(self, willPresent: superview)
        ToastView.animate(withDuration: 0.3, delay: 0, options: [.allowAnimatedContent, .curveEaseInOut]) {
            let constraint = self.constraints.first(where: { $0.constant == -200 })
            constraint?.identifier = "the one"
            constraint?.constant = 0
        } completion: { _ in
            self.delegate?.toast?(self, didPresent: self.superview)
            let userInfo: [String: Int] = ["id": self.id]
            self.timer = Timer(timeInterval: self.data.duration, target: self, selector: #selector(self.animateExit(_:)), userInfo: userInfo, repeats: false)
            self.delegate?.toast?(self, hasStartedTimer: self.timer)
        }

    }
    @objc func animateExit(_ userInfo: Any?) {
        delegate?.toast?(self, hasFiredTimer: timer)
        guard let userInfo = userInfo as? [String: Int], userInfo["id"] == id else { return }
        ToastView.animate(withDuration: 0.3, delay: 0, options: [.allowAnimatedContent, .curveEaseInOut]) {
            let constraint = self.constraints.first(where: { $0.identifier == "the one" })
            constraint?.constant = 0
        } completion: { _ in
            self.delegate?.toast?(self, hasEndedExitAnimation: self.superview)
            self.removeFromSuperview()
            NotificationCenter.default.post(Notification(name: notification(name: "toastEnded")))
        }
    }
    
}
