//
//  CustomModalViewController.swift
//  CoastalPulse
//
//  Created by Δήμητρα Μαλλιαρου on 23/4/23.
//

import UIKit

class CustomModalViewController: UIViewController, UISearchBarDelegate {

    let defaultHeight: CGFloat = 300
    let dismissibleHeight: CGFloat = 200
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    // keep updated with new height
    var currentContainerHeight: CGFloat = 300
    var textFirstLabel = ""
    lazy var titleLabel = UILabel()
    lazy var horView1 = UIView()
    lazy var horView2 = UIView()
    lazy var fullScreenView = UIView()
    
    // 1
        lazy var containerView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = 16
            view.clipsToBounds = true
            
            return view
        }()
        
        // 2
        let maxDimmedAlpha: CGFloat = 0.6
        lazy var dimmedView: UIView = {
            let view = UIView()
            view.backgroundColor = .black
            view.alpha = maxDimmedAlpha
            
            return view
        }()

    
        // 3. Dynamic container constraint
        var containerViewHeightConstraint: NSLayoutConstraint?
        var containerViewBottomConstraint: NSLayoutConstraint?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupPanGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
    
    func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }

    func animatePresentContainer() {
        // Update bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            // Call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    
    func setupPanGesture() {
        // add pan gesture recognizer to the view controller's view (the whole screen)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
        // change to false to immediately listen on gesture movement
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func animateDismissView() {
        // hide main container view by updating bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
    }
        
        // hide blur view
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            // once done, dismiss without animation
            self.dismiss(animated: false)
        }
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        // Drag to top will be minus value and vice versa
        print("Pan gesture y offset: \(translation.y)")

        // Get drag direction
        let isDraggingDown = translation.y > 0
        print("Dragging direction: \(isDraggingDown ? "going down" : "going up")")

        // New height is based on value of dragging plus current container height
        let newHeight = currentContainerHeight - translation.y

        // Handle based on gesture state
        switch gesture.state {
        case .changed:
            // This state will occur when user is dragging
            if newHeight < maximumContainerHeight {
                // Keep updating the height constraint
                containerViewHeightConstraint?.constant = newHeight
                // refresh layout
                self.fullScreenView.isHidden = false
                self.horView1.isHidden = true
                self.horView2.isHidden = true
                
                view.layoutIfNeeded()
            }
        case .ended:
            // This happens when user stop drag,
            // so we will get the last height of container
            // Condition 1: If new height is below min, dismiss controller
            if newHeight < dismissibleHeight {
                self.animateDismissView()
            }
            else if newHeight < defaultHeight {
                // Condition 2: If new height is below default, animate back to default
                self.fullScreenView.isHidden = true
                self.titleLabel.isHidden = false
                self.horView1.isHidden = false
                self.horView2.isHidden = false
                animateContainerHeight(defaultHeight)
            }
            else if newHeight < maximumContainerHeight && isDraggingDown {
                // Condition 3: If new height is below max and going down, set to default height
                self.fullScreenView.isHidden = true
                self.titleLabel.isHidden = false
                self.horView1.isHidden = false
                self.horView2.isHidden = false
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {
                // Condition 4: If new height is below max and going up, set to max height at top
                animateContainerHeight(maximumContainerHeight)
            }
        default:
            break
        }
    }

    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            // Update container height
            self.containerViewHeightConstraint?.constant = height
            // Call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
        // Save current height
        currentContainerHeight = height
    }
    
    func setupView() {
        view.backgroundColor = .clear
    }
        
        func setupConstraints() {
            // 4. Add subviews
            view.addSubview(dimmedView)
            view.addSubview(containerView)
            dimmedView.translatesAutoresizingMaskIntoConstraints = false
            containerView.translatesAutoresizingMaskIntoConstraints = false
            
            titleLabel = {
                let label = UILabel()
                label.frame = CGRect(x: 0, y: 0, width: 330, height: 30)
                label.text = self.textFirstLabel
                label.textColor = .black
                label.textAlignment = .center
                label.font = .boldSystemFont(ofSize: 20)
                return label
            }()

            horView1 = {
                let view = UIView()
                view.frame = CGRect(x: -20, y: 40, width: 380, height: 80)
                view.backgroundColor = .white
                let moVisit = UILabel()
                moVisit.frame = CGRect(x: 20, y: 0, width: 150, height: 80)
                moVisit.text = "Μέσος όρος επισκεπτών"
                moVisit.textColor = .black
                moVisit.numberOfLines = 0
                moVisit.font = .boldSystemFont(ofSize: 17)
                view.addSubview(moVisit)
                
                let moExpenses = UILabel()
                moExpenses.frame = CGRect(x: 220, y: 0, width: 150, height: 80)
                moExpenses.text = "Μέσος όρος Δαπανών"
                moExpenses.textColor = .black
                moExpenses.numberOfLines = 0
                moExpenses.font = .boldSystemFont(ofSize: 17)
                view.addSubview(moExpenses)
                
                return view
            }()
            
            horView2 = {
                let view = UIView()
                view.backgroundColor = .white
                view.frame = CGRect(x: -20, y: 100, width: 380, height: 80)
                let moVisit = UILabel()
                moVisit.frame = CGRect(x: 20, y: 0, width: 150, height: 50)
                moVisit.text = "43.7"
                moVisit.textColor = .black
                moVisit.numberOfLines = 0
                moVisit.font = .boldSystemFont(ofSize: 15)
                view.addSubview(moVisit)
                
                let moExpenses = UILabel()
                moExpenses.text = "322"
                moExpenses.frame = CGRect(x: 250, y: 0, width: 150, height: 50)
                moExpenses.textColor = .black
                moExpenses.numberOfLines = 0
                moExpenses.font = .boldSystemFont(ofSize: 15)
                view.addSubview(moExpenses)
                
                return view
            }()
            
            fullScreenView = {
                let view = UIView()
                view.frame = CGRect(x: 0, y: 40, width: containerView.frame.width, height: containerView.frame.height-50)
                view.backgroundColor = .blue
                view.layer.cornerRadius = 16
                
                let calculateROI = UILabel(frame: CGRect(x: 60, y: 30, width: 200, height: 40))
                calculateROI.text = "Υπολογισμός ROI%"
                calculateROI.textAlignment = .center
                calculateROI.textColor = .black
                view.addSubview(calculateROI)
                
                let searchBar = UISearchBar(frame: CGRect(x: 60, y: 60, width: 200, height: 50))
                searchBar.delegate = self
                view.addSubview(searchBar)
                
                searchBar.setImage(UIImage(systemName: "eurosign"), for: .search, state: .normal)
                
                searchBar.searchTextField.backgroundColor = UIColor(red: 0.96, green: 0.45, blue: 0.12, alpha: 0.29)
                searchBar.barTintColor = .clear
                searchBar.backgroundColor = UIColor.clear
                searchBar.isTranslucent = true
                searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
                
                let horView3: UIView = {
                    let view = UIView()
                    view.frame = CGRect(x: 10, y: 110, width: 380, height: 80)
                    view.backgroundColor = .white
                    
                    let moVisit = UILabel()
                    moVisit.frame = CGRect(x: 0, y: 0, width: 150, height: 80)
                    moVisit.text = "Μέσος όρος επισκεπτών"
                    moVisit.textColor = .black
                    moVisit.numberOfLines = 0
                    moVisit.font = .boldSystemFont(ofSize: 17)
                    view.addSubview(moVisit)
                    
                    let barChartView1 = BarChartView()
                    barChartView1.frame = CGRect(x: 0, y: 50, width: 340, height: 150)
                    barChartView1.dataEntries =
                    [
                       BarEntry(score: 15, title: "Q1"),
                       BarEntry(score: 35, title: "Q2"),
                       BarEntry(score: 45, title: "Q3"),
                    ]
                    view.addSubview(barChartView1)
                    
                    
                    return view
                }()
                
                let horView4: UIView = {
                    let view = UIView()
                    view.backgroundColor = .white
                    view.frame = CGRect(x: 10, y: 310, width: 380, height: 80)
                    
                    let moExpenses = UILabel()
                    moExpenses.frame = CGRect(x: 0, y: 0, width: 150, height: 80)
                    moExpenses.text = "Μέσος όρος Δαπανών"
                    moExpenses.textColor = .black
                    moExpenses.numberOfLines = 0
                    moExpenses.font = .boldSystemFont(ofSize: 17)
                    view.addSubview(moExpenses)
                    
                    let barChartView2 = BarChartView()
                    barChartView2.frame = CGRect(x: 0, y: 60, width: 340, height: 150)
                    barChartView2.dataEntries =
                    [
                       BarEntry(score: 15, title: "Q1"),
                       BarEntry(score: 35, title: "Q2"),
                       BarEntry(score: 45, title: "Q3"),
                    ]
                    view.addSubview(barChartView2)
                    
                    return view
                }()
                
                view.addSubview(horView3)
                view.addSubview(horView4)
                
                let subTitle = UILabel(frame: CGRect(x: 0, y: 520, width: 350, height: 30))
                subTitle.text = "Χώρα προέλευσης ταξιδιωτών"
                subTitle.textAlignment = .center
                subTitle.textColor = .black
                subTitle.font = .systemFont(ofSize: 20)
                subTitle.numberOfLines = 0
                view.addSubview(subTitle)
                
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
                layout.scrollDirection = .horizontal
                layout.itemSize = CGSize(width: 50, height: 50)
                
                
                let myCollectionView = UICollectionView(frame: CGRect(x: 50, y: 550, width: 250, height: 150), collectionViewLayout: layout)
                myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
                myCollectionView.dataSource = self
                myCollectionView.delegate = self
                myCollectionView.backgroundColor = UIColor.white
                view.addSubview(myCollectionView)
                
                return view
            }()
            
            lazy var contentStackView: UIStackView = {
                let spacer = UIView()
                let stackView = UIStackView()
                stackView.axis = .vertical
                stackView.addSubview(titleLabel)
                stackView.addSubview(horView1)
                stackView.addSubview(horView2)
                stackView.addSubview(fullScreenView)
                fullScreenView.isHidden = true
                stackView.addSubview(spacer)
                return stackView
            }()
            
            containerView.addSubview(contentStackView)
            contentStackView.translatesAutoresizingMaskIntoConstraints = false
            
            // 5. Set static constraints
            NSLayoutConstraint.activate([
                contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
                contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
                contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
                
                // set dimmedView edges to superview
                dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
                dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                // set container static constraint (trailing & leading)
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
            
            // 6. Set container to default height
            containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
            // 7. Set bottom constant to 0
            containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            // Activate constraints
            containerViewHeightConstraint?.isActive = true
            containerViewBottomConstraint?.isActive = true
        }
}
extension CustomModalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9 // How many cells to display
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        if indexPath.row == 0{
            var image : UIImage = UIImage(named: "81")!
            var imageView = UIImageView(image: image)
            myCell.addSubview(imageView)
        }
        if indexPath.row == 1{
            var image5 : UIImage = UIImage(named: "61")!
            var imageView = UIImageView(image: image5)
            myCell.addSubview(imageView)
        }
        if indexPath.row == 2{
            var image4 : UIImage = UIImage(named: "51")!
            var imageView = UIImageView(image: image4)
            myCell.addSubview(imageView)
        }
        if indexPath.row == 3{
            var image3 : UIImage = UIImage(named: "44")!
            var imageView = UIImageView(image: image3)
            myCell.addSubview(imageView)
        }
        if indexPath.row == 4{
            var image2 : UIImage = UIImage(named: "71")!
            var imageView = UIImageView(image: image2)
            myCell.addSubview(imageView)
        }
    
        
        myCell.backgroundColor = UIColor.white
        return myCell
    }
}
extension CustomModalViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("User tapped on item \(indexPath.row)")
    }
}
