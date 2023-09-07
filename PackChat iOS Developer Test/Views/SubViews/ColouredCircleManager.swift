import UIKit

class ColouredCircleManager {
    var xOffset: CGFloat = Constants.offsetSpacing
    var colours: [(name: String, colour: UIColor)] = []
    var onCircleTapped: ((String, UIColor) -> Void)?

       init(colours: [(name: String, colour: UIColor)]) {
           self.colours = colours
       }

    func addGestureRecognizers(to circleView: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(circleTapped(_:)))
        circleView.addGestureRecognizer(tapGesture)
    }

    @objc func circleTapped(_ sender: UITapGestureRecognizer) {
        if let view = sender.view, view.tag < colours.count {
            let colourName = colours[view.tag].name
            let colour = colours[view.tag].colour
            onCircleTapped?(colourName, colour)
        }
    }

    func addColouredCircles(to scrollView: UIScrollView) {
        for index in 0..<colours.count {
            let colourInfo = colours[index]
            createCircle(with: colourInfo, at: index, in: scrollView)
        }
        updateScrollViewContentSize(for: scrollView)
    }

    func createCircle(with colourInfo: (name: String, colour: UIColor), at index: Int, in scrollView: UIScrollView) {
        let (circleView, colourLabel) = generateCircleAndLabel(with: colourInfo)

        circleView.tag = index
        addGestureRecognizers(to: circleView)

        scrollView.addSubview(circleView)
        scrollView.addSubview(colourLabel)
        setupCircleViewConstraints(circleView: circleView, andLabel: colourLabel, in: scrollView)
    }

    func generateCircleAndLabel(with colourInfo: (name: String, colour: UIColor)) -> (UIView, UILabel) {
        let (name, colour) = colourInfo

        let circleView = UIView()
        circleView.backgroundColor = colour
        circleView.layer.cornerRadius = Constants.circleCornerRadius
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.isUserInteractionEnabled = true

        let colourLabel = UILabel()
        colourLabel.text = name
        colourLabel.translatesAutoresizingMaskIntoConstraints = false

        return (circleView, colourLabel)
    }

    func setupCircleViewConstraints(circleView: UIView, andLabel colourLabel: UILabel, in scrollView: UIScrollView) {
        NSLayoutConstraint.activate([
            circleView.widthAnchor.constraint(equalToConstant: Constants.circleDiameter),
            circleView.heightAnchor.constraint(equalToConstant: Constants.circleDiameter),
            circleView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: xOffset),
            circleView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),

            colourLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            colourLabel.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: Constants.offsetSpacing),
        ])

        xOffset += Constants.circleSpacing
    }

    func updateScrollViewContentSize(for scrollView: UIScrollView) {
        scrollView.contentSize = CGSize(width: xOffset, height: Constants.scrollViewHeight)
    }
}

extension ColouredCircleManager {
    enum Constants {
        static let circleDiameter: CGFloat = 50
        static let circleSpacing: CGFloat = 70
        static let circleCornerRadius: CGFloat = 25
        static let scrollViewHeight: CGFloat = 110
        static let offsetSpacing: CGFloat = 10
    }
}
