import UIKit

extension ColoursViewController {
    func addColouredCircles() {
        for index in 0..<colours.count {
            let colourInfo = colours[index]
            createCircle(with: colourInfo, at: index)
        }
        updateScrollViewContentSize()
    }

    func createCircle(with colourInfo: (name: String, colour: UIColor), at index: Int) {
        let (circleView, colourLabel) = generateCircleAndLabel(with: colourInfo)

        circleView.tag = index
        addGestureRecognizers(to: circleView)

        scrollView.addSubview(circleView)
        scrollView.addSubview(colourLabel)
        setupCircleViewConstraints(circleView: circleView, andLabel: colourLabel)
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

    func addGestureRecognizers(to circleView: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(circleTapped(_:)))
        circleView.addGestureRecognizer(tapGesture)
    }

    func setupCircleViewConstraints(circleView: UIView, andLabel colourLabel: UILabel) {
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

    func updateScrollViewContentSize() {
        scrollView.contentSize = CGSize(width: xOffset, height: Constants.scrollViewHeight)
    }
}
