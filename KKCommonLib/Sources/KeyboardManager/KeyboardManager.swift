import UIKit

open class KeyboardManager: NSObject, UIGestureRecognizerDelegate {
    
    public typealias EventCallback = (KeyboardNotification)->Void
    
    // MARK: - Properties [Public]
    open weak var inputAccessoryView: UIView?
    
    private(set) public var isKeyboardHidden: Bool = true
    
    // MARK: - Properties [Private]
    private var constraints: NSLayoutConstraintSet?
    
    private weak var scrollView: UIScrollView?
    
    private var callbacks: [KeyboardEvent: EventCallback] = [:]
    
    private var panGesture: UIPanGestureRecognizer?

    private var cachedNotification: KeyboardNotification?
    
    // MARK: - Initialization
    public convenience init(inputAccessoryView: UIView) {
        self.init()
        self.bind(inputAccessoryView: inputAccessoryView)
    }
    
    public override init() {
        super.init()
        addObservers()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - De-Initialization
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Keyboard Observer
    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidShow(notification:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidHide(notification:)),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrame(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidChangeFrame(notification:)),
                                               name: UIResponder.keyboardDidChangeFrameNotification,
                                               object: nil)
    }
    
    // MARK: - Mutate Callback Dictionary
    @discardableResult
    open func on(event: KeyboardEvent, do callback: EventCallback?) -> Self {
        callbacks[event] = callback
        return self
    }
    
    @discardableResult
    open func bind(inputAccessoryView: UIView) -> Self {
        
        guard let superview = inputAccessoryView.superview else {
            fatalError("`inputAccessoryView` must have a superview")
        }
        self.inputAccessoryView = inputAccessoryView
        inputAccessoryView.translatesAutoresizingMaskIntoConstraints = false
        constraints = NSLayoutConstraintSet(
            bottom: inputAccessoryView.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            left: inputAccessoryView.leftAnchor.constraint(equalTo: superview.leftAnchor),
            right: inputAccessoryView.rightAnchor.constraint(equalTo: superview.rightAnchor)
        ).activate()
        
        callbacks[.willShow] = { [weak self] (notification) in
            let keyboardHeight = notification.endFrame.height
            guard
                self?.isKeyboardHidden == false,
                self?.constraints?.bottom?.constant == 0,
                notification.isForCurrentApp else { return }
            self?.animateAlongside(notification) {
                self?.constraints?.bottom?.constant = -keyboardHeight
                self?.inputAccessoryView?.superview?.layoutIfNeeded()
            }
        }
        callbacks[.willChangeFrame] = { [weak self] (notification) in
            let keyboardHeight = notification.endFrame.height
            guard
                self?.isKeyboardHidden == false,
                notification.isForCurrentApp else { return }
            self?.animateAlongside(notification) {
                self?.constraints?.bottom?.constant = -keyboardHeight
                self?.inputAccessoryView?.superview?.layoutIfNeeded()
            }
        }
        callbacks[.willHide] = { [weak self] (notification) in
            guard notification.isForCurrentApp else { return }
            self?.animateAlongside(notification) { [weak self] in
                self?.constraints?.bottom?.constant = 0
                self?.inputAccessoryView?.superview?.layoutIfNeeded()
            }
        }
        return self
    }
    
    @discardableResult
    open func bind(to scrollView: UIScrollView) -> Self {
        self.scrollView = scrollView
        self.scrollView?.keyboardDismissMode = .interactive
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer))
        recognizer.delegate = self
        self.panGesture = recognizer
        self.scrollView?.addGestureRecognizer(recognizer)
        return self
    }
    
    // MARK: - Keyboard Notifications
    @objc
    open func keyboardDidShow(notification: NSNotification) {
        guard let keyboardNotification = KeyboardNotification(from: notification) else { return }
        callbacks[.didShow]?(keyboardNotification)
    }
    
    @objc
    open func keyboardDidHide(notification: NSNotification) {
        isKeyboardHidden = true
        guard let keyboardNotification = KeyboardNotification(from: notification) else { return }
        callbacks[.didHide]?(keyboardNotification)
    }
    
    @objc
    open func keyboardDidChangeFrame(notification: NSNotification) {
        guard let keyboardNotification = KeyboardNotification(from: notification) else { return }
        callbacks[.didChangeFrame]?(keyboardNotification)
        cachedNotification = keyboardNotification
    }
    
    @objc
    open func keyboardWillChangeFrame(notification: NSNotification) {
        guard let keyboardNotification = KeyboardNotification(from: notification) else { return }
        callbacks[.willChangeFrame]?(keyboardNotification)
        cachedNotification = keyboardNotification
    }
    
    @objc
    open func keyboardWillShow(notification: NSNotification) {
        isKeyboardHidden = false
        guard let keyboardNotification = KeyboardNotification(from: notification) else { return }
        callbacks[.willShow]?(keyboardNotification)
    }
    
    @objc
    open func keyboardWillHide(notification: NSNotification) {
        guard let keyboardNotification = KeyboardNotification(from: notification) else { return }
        callbacks[.willHide]?(keyboardNotification)
    }
    
    // MARK: - Helper Methods
    private func animateAlongside(_ notification: KeyboardNotification, animations: @escaping ()->Void) {
        UIView.animate(withDuration: notification.timeInterval, delay: 0, options: [notification.animationOptions, .allowAnimatedContent, .beginFromCurrentState], animations: animations, completion: nil)
    }
    
    // MARK: - UIGestureRecognizerDelegate
    @objc
    open func handlePanGestureRecognizer(recognizer: UIPanGestureRecognizer) {
        guard
            var keyboardNotification = cachedNotification,
            case .changed = recognizer.state,
            let view = recognizer.view,
            let window = UIApplication.shared.windows.first
            else { return }
        
        let location = recognizer.location(in: view)
        let absoluteLocation = view.convert(location, to: window)
        var frame = keyboardNotification.endFrame
        frame.origin.y = max(absoluteLocation.y, window.bounds.height - frame.height)
        frame.size.height = window.bounds.height - frame.origin.y
        keyboardNotification.endFrame = frame
        callbacks[.willChangeFrame]?(keyboardNotification)
    }
    
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return scrollView?.keyboardDismissMode == .interactive
    }
    
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer === panGesture
    }
    
}
