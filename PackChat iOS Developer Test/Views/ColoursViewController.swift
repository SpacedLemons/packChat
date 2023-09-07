import UIKit

class ColoursViewController: UIViewController {
    //MARK: UI Element

    private let scrollView = UIScrollView()
    private let selectColoursStackView = UIStackView()

    var selectedColours: [String] = []

    private let circleManager = ColouredCircleManager(colours: [
        ("Red", .systemRed),
        ("Yellow", .systemYellow),
        ("Green", .systemGreen),
        ("Indigo", .systemIndigo),
        ("Orange", .systemOrange),
        ("Purple", .systemPurple),
        ("Brown", .systemBrown),
        ("Cyan", .systemCyan)
    ])

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "PackChat iOS Test"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: Constants.titleLabelFontSize, weight: .bold)
        label.textColor = .black
        return label
    }()

    private var recentlySelectedTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Most Recently Selected"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: Constants.recentlySelectedTitleFontSize, weight: .medium)
        label.textColor = .black
        return label
    }()

    private var arrowLabel: UILabel = {
        let label = UILabel()
        label.text = "↓"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: Constants.titleLabelFontSize, weight: .medium)
        label.textColor = .black
        return label
    }()

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
        view.addSubview(titleLabel)
        view.addSubview(recentlySelectedTitleLabel)
        view.addSubview(arrowLabel)
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

    func addColourToSelectedList(_ colourName: String) {
        selectedColours.insert(colourName, at: 0)

        let selectedColourLabel = UILabel()
        selectedColourLabel.text = colourName
        selectedColourLabel.textAlignment = .center

        if let colour = circleManager.colour(forName: colourName) {
            selectedColourLabel.backgroundColor = colour
        }

        selectColoursStackView.insertArrangedSubview(selectedColourLabel, at: 0)
    }

    private func setupStackView() {
        selectColoursStackView.axis = .vertical
        selectColoursStackView.distribution = .fill
        selectColoursStackView.spacing = Constants.textSpacing
    }

    private func setupConstraints() {
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        selectColoursStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        recentlySelectedTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            recentlySelectedTitleLabel.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: Constants.recentlySelectedTitleTopAnchor),
            recentlySelectedTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            recentlySelectedTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            recentlySelectedTitleLabel.heightAnchor.constraint(equalToConstant: Constants.recentlySelectedTitleHeightAnchor),

            arrowLabel.topAnchor.constraint(equalTo: recentlySelectedTitleLabel.bottomAnchor, constant: Constants.arrowLabelTopAnchor),
            arrowLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            arrowLabel.heightAnchor.constraint(equalToConstant: Constants.arrowLabelWidthHeightAnchor),
            arrowLabel.widthAnchor.constraint(equalToConstant: Constants.arrowLabelWidthHeightAnchor)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleLabelTopAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.titleLabelHeightAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: Constants.titleLabelWidthAnchor),
            
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.scrollViewTitleLabelTopAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.scrollViewLeadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.scrollViewTrailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: Constants.scrollViewHeightConstraint),

            selectColoursStackView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: Constants.stackViewTopAnchor),
            selectColoursStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            selectColoursStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

//MARK: - Constants

extension ColoursViewController {
    enum Constants {
        static let scrollViewHeightConstraint: CGFloat = 140
        static let scrollViewLeadingAnchor: CGFloat = 10
        static let scrollViewTrailingAnchor: CGFloat = -10
        static let scrollViewTitleLabelTopAnchor: CGFloat = 16
        static let stackViewTopAnchor: CGFloat = 120
        static let titleLabelFontSize: CGFloat = 24
        static let titleLabelTopAnchor: CGFloat = 16
        static let titleLabelHeightAnchor: CGFloat = 30
        static let titleLabelWidthAnchor: CGFloat = 250
        static let arrowLabelWidthHeightAnchor: CGFloat = 20
        static let arrowLabelTopAnchor: CGFloat = 4
        static let recentlySelectedTitleHeightAnchor: CGFloat = 20
        static let recentlySelectedTitleTopAnchor: CGFloat = 40
        static let recentlySelectedTitleFontSize: CGFloat = 18
        static let fontTitleSize: CGFloat = 24
        static let textSpacing: CGFloat = 10
    }
}
