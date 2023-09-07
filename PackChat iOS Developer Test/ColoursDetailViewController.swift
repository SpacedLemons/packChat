import UIKit
import AVFoundation

class ColoursDetailViewController: UIViewController {

    var backgroundColor: UIColor?
    var colourName: String?
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let soundURL = Bundle.main.url(forResource: "cheering", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            } catch {
                print("Could not load sound file.")
            }
        }

        view.backgroundColor = backgroundColor

        let label = UILabel()
        label.text = colourName
        label.translatesAutoresizingMaskIntoConstraints = false

        let button = UIButton()
        button.setTitle("Press Me", for: .normal)
        button.backgroundColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false

        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        view.addSubview(label)
        view.addSubview(button)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),

            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
    }

    @objc func buttonPressed() {
        audioPlayer?.play()

        let ranOutOfTimeViewController = RanOutOfTimeViewController()
        self.navigationController?.pushViewController(ranOutOfTimeViewController, animated: true)
    }
}
