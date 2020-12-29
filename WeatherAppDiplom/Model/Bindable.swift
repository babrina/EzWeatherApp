import Foundation

class Bindable<T> {
  typealias Listener = (T) -> Void

    var value: T {
      didSet {
          DispatchQueue.main.async {
              self.listener?(self.value)
          }
      }
    }
    
  private var listener: Listener?

  init(_ value: T) {
    self.value = value
  }

  /**
   - Important:
     Best pratice is to only set any UI attribute in a single binding. Failing to follow
     that suggestion can result in hard to track bugs where the order that values are set results in
     different UI outcomes.

   - Parameters:
        - listener: The *closure* to execute when respond to value changes.
   */
  func bind(_ listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
