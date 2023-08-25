//
//  ViewController.swift
//  EmbeedPDFinApp
//
//  Created by Mac on 25/08/23.
//

import UIKit
import PDFKit

class ViewController: UIViewController {

    var pdfviewObject: PDFView = PDFView()
    var pdfDocumentObject: PDFDocument = PDFDocument()
    var totalPageControl = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pdfviewObject = PDFView(frame: self.view.bounds)
        self.view.addSubview(pdfviewObject)
        guard let path = Bundle.main.url(forResource: "2", withExtension: "pdf")
                else
        {
            print("Error in PDF Path")
            return
        }
        pdfDocumentObject = PDFDocument(url: path)!
        pdfviewObject.document = pdfDocumentObject
        pdfviewObject.autoScales = true
        pdfviewObject.displayMode = .singlePage
        pdfviewObject.displayDirection = .vertical
        pdfviewObject.usePageViewController(true)
       totalPageControl = 0
        
        if let total = pdfviewObject.document?.pageCount
        {
            totalPageControl = total
        }
        NotificationCenter.default.addObserver(self, selector: #selector(countPages), name: Notification.Name.PDFViewPageChanged, object: nil)
        
        countPages()
    }
    @objc func countPages(){
        let currentPageNumber = pdfDocumentObject.index(for: pdfviewObject.currentPage!)+1
        let totalPage = "\(currentPageNumber)/ \(totalPageControl)"
        title = "PDF Viewer \(totalPage)"
    }

}

