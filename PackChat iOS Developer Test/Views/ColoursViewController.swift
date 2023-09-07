import UIKit

class ColoursViewController: UIViewController {
    //MARK: UI Element

    let scrollView = UIScrollView()
    let selectColoursStackView = UIStackView()

    private let circleManager = ColouredCircleManager(colours: [
         ("Red", .systemRed),
         ("Yellow", .systemYellow),
         ("Green", .systemGreen),
         ("Blue", .systemBlue),
         ("Orange", .systemOrange),
         ("Purple", .systemPurple),
         ("Brown", .systemBrown),
         ("Cyan", .systemCyan)
     ])

    var selectedColours: [String] = []

    //MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

    //MARK: Methods

    private func initialSetup() {
        setupUIElements()
        setupConstraints()
        setupStackView()
        setupCircleManager()
    }

    private func setupUIElements() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addSubview(selectColoursStackView)
    }

    private func setupCircleManager() {
        circleManager.onCircleTapped = { [weak self] (colourName, colour) in
            self?.addColourToSelectedList(colourName)

            let coloursDetailViewController = ColoursDetailViewController()
            coloursDetailViewController.backgroundColor = colour
            coloursDetailViewController.colourName = colourName
            self?.navigationController?.pushViewController(coloursDetailViewController, animated: true)
        }

        circleManager.addColouredCircles(to: scrollView)
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
