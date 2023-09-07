import UIKit

class ColouredCircleManager {
    private var xOffset: CGFloat = Constants.offsetSpacing
    private var colours: [ColourData] = []
    var onCircleTapped: ((String, UIColor) -> Void)?

    init(colours: [(name: String, colour: UIColor)]) {
        self.colours = colours.map { ColourData(name: $0.name, colour: $0.colour) }
        self.onCircleTapped = nil
    }

    func colour(forName name: String) -> UIColor? {
        return colours.first { $0.name == name }?.colour
    }

    private func addGestureRecognizers(to circleView: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(circleTapped(_:)))
        circleView.addGestureRecognizer(tapGesture)
    }

    @objc func circleTapped(_ sender: UITapGestureRecognizer) {
        if let view = sender.view, view.tag < colours.count {
            let index = view.tag
            let colourInfo = colours[index]
            onCircleTapped?(colourInfo.name, colourInfo.colour)
        }
    }

    func addColouredCircles(to scrollView: UIScrollView) {
        for index in 0..<colours.count {
            createCircle(at: index, in: scrollView)
        }
        updateScrollViewContentSize(for: scrollView)
    }

    private func createCircle(at index: Int, in scrollView: UIScrollView) {
        guard index < colours.count else {
            return
        }

        let colourInfo = colours[index]

        let circleView = UIView()
        circleView.backgroundColor = colourInfo.colour
        circleView.layer.cornerRadius = Constants.circleCornerRadius
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.isUserInteractionEnabled = true

        let colourLabel = UILabel()
        colourLabel.text = colourInfo.name
        colourLabel.translatesAutoresizingMaskIntoConstraints = false

        circleView.tag = index
        addGestureRecognizers(to: circleView)

        scrollView.addSubview(circleView)
        scrollView.addSubview(colourLabel)
        setupCircleViewConstraints(circleView: circleView, andLabel: colourLabel, in: scrollView)
    }

    private func setupCircleViewConstraints(circleView: UIView, andLabel colourLabel: UILabel, in scrollView: UIScrollView) {
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

    private func updateScrollViewContentSize(for scrollView: UIScrollView) {
        scrollView.contentSize = CGSize(width: xOffset, height: Constants.expandedScrollViewHeight)
    }
}

extension ColouredCircleManager {
    enum Constants {
        static let circleDiameter: CGFloat = 50
        static let circleSpacing: CGFloat = 75
        static let circleCornerRadius: CGFloat = 25
        static let offsetSpacing: CGFloat = 10
        static let expandedScrollViewHeight: CGFloat = 130
    }
}
