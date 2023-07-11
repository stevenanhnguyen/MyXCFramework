//
//  IntroductionVC.swift
//  hataraki_nurse_ios
//
//  Created by TuNA on 4/27/20.
//  Copyright © 2020 Hung Nguyen. All rights reserved.
//

import Foundation
import UIKit

class IntroductionVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnNext: UIButton!
    
    var slides: [Slide] = [];
    private var currentPage: CGFloat = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        slides = createSlides()
        setText()
        setupSlideScrollView(slides: slides)
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        btnNext.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        if Int(currentPage) == slides.count - 1 {
            showLogin()
        } else {
            goToNextPage()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: 0)
        if (Int(self.currentPage) == self.slides.count - 1){
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(gesture:)))
            swipeLeft.direction = .left
            scrollView.panGestureRecognizer.require(toFail: swipeLeft)
            self.scrollView.addGestureRecognizer(swipeLeft)
        }
    }
    
    // MARK: Set text value in the view
    private func setText(){
        btnNext.setTitle("BTN_NEXT", for: .normal)
        btnNext.layer.borderColor = UIColor.white.cgColor
        btnNext.layer.borderWidth = 1
        btnNext.layer.cornerRadius = btnNext.frame.height/2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Create UI Slide
    func createSlides() -> [Slide] {
        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageView.image = UIImage(named: "intro01")
        slide1.labelTitle.text = "TITLE_INTRO_1"
        slide1.labelDesc.text = "DES_INTRO_1"
        slide1.backgroundColor = Resource.Color.burntSienna
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imageView.image = UIImage(named: "intro02")
        slide2.labelTitle.text = "TITLE_INTRO_2"
        slide2.labelDesc.text = "DES_INTRO_2"
        slide2.backgroundColor = Resource.Color.appleGreen
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.imageView.image = UIImage(named: "intro03")
        slide3.labelTitle.text = "TITLE_INTRO_3"
        slide3.labelDesc.text = "DES_INTRO_3"
        slide3.backgroundColor = Resource.Color.seaBuckthorn
        
        
        return [slide1, slide2, slide3]
    }
    
    // MARK: Setup ScrollView
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    /*
     * default function called when view is scolled. In order to enable callback
     * when scrollview is scrolled, the below code needs to be called:
     * slideScrollView.delegate = self or
     */
    
    // MARK: ScrollView Did Scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        self.currentPage = pageIndex
        self.validateCurrentPage()
    }
    
    // MARK: Color Scroll
    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
        if(pageControl.currentPage == 0) {
            let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.pageIndicatorTintColor = pageUnselectedColor
            
            let bgColor: UIColor = fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            slides[pageControl.currentPage].backgroundColor = bgColor
            
            let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.currentPageIndicatorTintColor = pageSelectedColor
        }
    }
    
    func fade(fromRed: CGFloat,
              fromGreen: CGFloat,
              fromBlue: CGFloat,
              fromAlpha: CGFloat,
              toRed: CGFloat,
              toGreen: CGFloat,
              toBlue: CGFloat,
              toAlpha: CGFloat,
              withPercentage percentage: CGFloat) -> UIColor {
        
        let red: CGFloat = (toRed - fromRed) * percentage + fromRed
        let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
        let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
        let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha
        
        /// return the fade colour
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // Go to the next page of introduction view.
    private func goToNextPage(){
        DispatchQueue.main.async {
            self.currentPage += 1
            guard self.validateCurrentPage(currentPage: self.currentPage) else{
                return
            }
            let newContentXOffset = (self.currentPage) * self.scrollView.frame.width
            let newContentOffset = CGPoint(x: newContentXOffset, y: self.scrollView.contentOffset.y)
            self.scrollView.setContentOffset(newContentOffset, animated: true)
        }
    }
    
    // MARK: Validate To next Page
    fileprivate func validateCurrentPage(currentPage: CGFloat = 0) -> Bool{
        if (Int(self.currentPage) == self.slides.count - 1){
            self.btnNext.setTitle("BTN_DONE", for: .normal)
        }
        else{
            self.btnNext.setTitle("BTN_NEXT", for: .normal)
        }
        guard Int(self.currentPage) < self.slides.count else {
            return false
        }
        return true
    }

    //MARK: - Util Methods
    func getFontSize(button:UIButton) -> CGFloat{
        let ratio = UIScreen.main.bounds.height/667
        if ratio < 1.0 {
            if let size = button.titleLabel?.font.pointSize {
                return size*ratio
            }
        }
        return button.titleLabel?.font.pointSize ?? 0.0
    }
    
    @objc func swipeLeft(gesture:UISwipeGestureRecognizer) -> Void {
        if (Int(self.currentPage) == self.slides.count - 1){
            self.showLogin()
        } else {
            self.goToNextPage()
        }
    }
}
