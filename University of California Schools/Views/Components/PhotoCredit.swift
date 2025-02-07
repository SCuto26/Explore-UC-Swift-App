//
//  PhotoCredit.swift
//  University of California Schools
//
//  Created by Stefan Cutovic on 2/4/25.
//

import SwiftUI
import SafariServices

struct PhotoCreditView: View {
    let schoolName: String
    @State private var showingSafariView = false
    
    private func getPhotoCredit() -> URL? {
        let urlString: String
        switch schoolName {
        case "Berkeley":
            urlString = "https://www.tclf.org/landscapes/university-california-berkeley"
        case "UC Davis":
            urlString = "https://www.flickr.com/photos/goodlifegarden/17748884668/in/photostream/"
        case "UCI":
            urlString = "https://www.flickr.com/photos/goodlifegarden/17748884668/in/photostream/"
        case "UCLA":
            urlString = "https://luskinconferencecenter.ucla.edu/your-guide-to-visiting-the-ucla-campus/"
        case "UC Merced":
            urlString = "https://www.collegeright.com/university-of-california-merced/"
        case "UC Riverside":
            urlString = "https://www.universityofcalifornia.edu/news/uc-riverside-invited-join-aau"
        case "UC San Diego", "UCSD":
            urlString = "https://today.ucsd.edu/story/uc-san-diego-named-no-3-top-public-college-by-forbes"
        case "UC Santa Barbara", "UCSB":
            urlString = "https://www.ucsb.edu/COVID-19-information"
        case "UC Santa Cruz":
            urlString = "https://reciprocity.uceap.universityofcalifornia.edu/discover-uc/discover-uc-santa-cruz"
        default:
            return nil
        }
        return URL(string: urlString)
    }
    
    var body: some View {
            if let _ = getPhotoCredit() {
                Button {
                    showingSafariView = true
                } label: {
                    Text("Picture Credits")
                        .font(.caption2)
                        .foregroundStyle(.gray)  // Changed to use system-standard navigation styling
                }
                .sheet(isPresented: $showingSafariView) {
                    if let url = getPhotoCredit() {
                        SafariView(url: url)
                    }
                }
            }
        }
    }

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
    }
}
