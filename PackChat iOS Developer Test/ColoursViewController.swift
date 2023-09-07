import UIKit

class ColoursViewController: UIViewController {
    //MARK: UI Element

    let scrollView = UIScrollView()
    let selectColoursStackView = UIStackView()
    var xOffset: CGFloat = Constants.offsetSpacing
    var selectedColours: [String] = []

    let colours: [(name: String, colour: UIColor)] = [
        ("Red", .systemRed),
        ("Yellow", .systemYellow),
        ("Green", .systemGreen),
        ("Blue", .systemBlue),
        ("Orange", .systemOrange),
        ("Purple", .systemPurple)
    ]

    //MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
        setupStackView()
        addColouredCircles()
    }

    //MARK: Methods

    private func setup() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addSubview(selectColoursStackView)
    }

    @objc func circleTapped(_ sender: UITapGestureRecognizer) {
        if let view = sender.view, view.tag < colours.count {
            let colourName = colours[view.tag].name
            let colour = colours[view.tag].colour
            addColourToSelectedList(colourName)

            let coloursDetailViewController = ColoursDetailViewController()
            coloursDetailViewController.backgroundColor = colour
            coloursDetailViewController.colourName = colourName
            self.navigationController?.pushViewController(coloursDetailViewController, animated: true)
        }
    }

    private func addColourToSelectedList(_ colourName: String) {
        selectedColours.insert(colourName, at: 0)

        let newLabel = UILabel()
        newLabel.text = colourName
        selectColoursStackView.insertArrangedSubview(newLabel, at: 0)
    }

    private func setupStackView() {
        selectColoursStackView.axis = .vertical
        selectColoursStackView.distribution = .fillEqually
        selectColoursStackView.spacing = Constants.offsetSpacing
    }

    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        selectColoursStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: Constants.scrollViewHeight),

            selectColoursStackView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: Constants.stackViewTopAnchor),
            selectColoursStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            selectColoursStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

//MARK: - Constants

extension ColoursViewController {
    enum Constants {
        static let circleDiameter: CGFloat = 50
        static let circleSpacing: CGFloat = 70
        static let circleCornerRadius: CGFloat = 25
        static let scrollViewHeight: CGFloat = 110
        static let stackViewTopAnchor: CGFloat = 20
        static let labelTopPadding: CGFloat = 12
        static let offsetSpacing: CGFloat = 10
    }
}
