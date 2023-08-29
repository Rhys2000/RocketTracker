//
//  InfoView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/28/23.
//

import SwiftUI

struct InfoView: View {
    
    @EnvironmentObject private var vm: LaunchViewModel
    
    var body: some View {
        NavigationView {
            Form {
                versionSection
                connectSection
                contactSection
                acknowledgementsSection
                policySection
            }
            .background(Color.theme.primaryBackground)
            .scrollContentBackground(.hidden)
            .navigationBarTitle("Information", displayMode: .inline)
            .toolbarBackground(Color.theme.primaryBackground)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    CloseSheetButton(closeSheet: $vm.isInfoPresented)
                }
            }
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView().environmentObject(LaunchViewModel())
    }
}

extension InfoView {
    
    private var versionSection: some View {
        Section(header: sectionHeader("RocketTracker")) {
            sectionRow("Version 3.0.4", "Last Updated: 28 August 2023", "")
        }
        .listRowBackground(Color.theme.secondaryBackground)
    }
    
    private var connectSection: some View {
        Section(header: sectionHeader("Connect")) {
            sectionRow("Twitter", "Follow me on Twitter / X for updates about my coding journey", "https://twitter.com/chickenwithrhys")
            sectionRow("LinkedIn", "Follow me on LinkedIn to view my job experience and latest posts", "https://www.linkedin.com/in/rhys-julian-jones-619886158/")
            sectionRow("GitHub", "Check out my GitHub respositories and projects I have worked on", "https://github.com/Rhys2000")
            sectionRow("Personal Website", "Check out my online portfolio where I display other applications I have designed", "")
        }
        .listRowBackground(Color.theme.secondaryBackground)
    }
    
    private var contactSection: some View {
        Section(header: sectionHeader("Contact")) {
            sectionRow("Email", "Please let me know if you find a bug or have any issues with the application. Feedback is greatly appreciated", "rhys2kjj@gmail.com")
            sectionRow("Phone Number", "Please call me with an inquiries about possible interviews or job opportunities", "")
        }
        .listRowBackground(Color.theme.secondaryBackground)
    }
    
    private var acknowledgementsSection: some View {
        Section(header: sectionHeader("Acknowledgements")) {
            sectionRow("NextSpaceFlight.com", "NextSpaceflight.com is a comprehensive online platform offering real-time updates and information on upcoming spaceflights and rocket launches worldwide.", "https://nextspaceflight.com")
            sectionRow("EverydayAstronaut.com", "EverydayAstronaut.com is an engaging and informative website created by Tim Dodd, featuring space exploration articles, educational resources, and entertaining content designed to make learning about space accessible to everyone.", "https://everydayastronaut.com")
            sectionRow("SpaceX Flickr", "SpaceX frequently updates its Flickr account with stunning photographs of its rocket launches and space missions, offering a captivating glimpse into the realm of space exploration.", "https://www.flickr.com/photos/spacex/")
            sectionRow("Gunter's Space Page", "Gunter's Space Page is an extensive online resource providing detailed information and tracking data on space missions, launch vehicles, and satellites, curated by author and space enthusiast Gunter Krebs.", "https://space.skyrocket.de/index.html")
            sectionRow("planet4589.org", "Planet4589.org is a prominent online repository managed by Jonathan McDowell, offering a wealth of data and documentation related to space objects, including satellites, rockets, and orbital debris, serving as a valuable resource for space researchers and enthusiasts.", "http://planet4589.org")
            sectionRow("Encyclopedia Austronautica", "Astronautix is a comprehensive online resource providing detailed information and historical context about space exploration, space technology, and space-related events.", "http://www.astronautix.com")
            sectionRow("Wikipedia", "The curators over at Wikipedia have created an extensive list of launch information about Falcon 9 and Falcon Heavy launches.", "https://en.wikipedia.org/wiki/List_of_Falcon_9_and_Falcon_Heavy_launches")
            sectionRow("SpaceOffshore.com", "Website that tracks all vessels that are used in the support and recovery of rocket launches including chartered vessels and fairing catchers.", "https://space-offshore.com")
            sectionRow("ElonX.net", "Tracks numerous aspects of SpaceX operations including fairing recovery, static fires, and booster landings.", "https://www.elonx.net")
            sectionRow("Raul74Cz", "Creates maps of launch hazard areas, and several other import SpaceX landmarks. Also tracks fairing reuse, booster landings, and important mission milestones.", "https://t.co/RAsQ9NDmEr")
        }
        .listRowBackground(Color.theme.secondaryBackground)
    }
    
    private var policySection: some View {
        Section(header: sectionHeader("Policies")) {
            sectionRow("Privacy Policy", "Get to know our privacy practices, how we collect and process data, and your choices about how information is used, in a format that is easy to read and navigate.", "")
            sectionRow("Legal Policy", "Review the terms of your agreement with RocketTracker in the use of our application", "")
            sectionRow("Frequently Asked Questions", "A concise compilation of frequently asked questions and their corresponding answers, designed to provide quick and helpful information to users about a particular topic or service.", "")
        }
        .listRowBackground(Color.theme.secondaryBackground)
    }
    
    private func sectionHeader(_ header: String) -> some View {
        Text(header)
            .font(.title)
            .bold()
            .fontDesign(.rounded)
            .foregroundColor(Color.theme.accent)
        
    }
    
    private func sectionRow(_ headline: String, _ subHeadline: String, _ url: String) -> some View {
        VStack(alignment: .leading) {
            Text(headline)
                .foregroundColor(Color.theme.primaryText)
                .font(.title3)
                .fontWeight(.semibold)
                .bold()
                .padding(.bottom, 1)
            Text(subHeadline)
                .foregroundColor(Color.theme.secondaryText)
        }
        .onTapGesture {
            openProfileLink(givenUrl: url)
        }
    }
    
    func openProfileLink(givenUrl: String) {
        if let url = URL(string: givenUrl) {
            UIApplication.shared.open(url)
        }
    }
}
