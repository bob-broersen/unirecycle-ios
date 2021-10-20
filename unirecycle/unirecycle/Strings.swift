//
//  Strings.swift
//  unirecycle
//
//  Created by Bob Broersen on 04/02/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation

struct Page{
    let imageName: String
    let title: String
    let description: String
}

struct RegistrationRequirment{
    let text : String
    let regex: String
}

struct ChallengeCategory{
    let name: String
    let imageName: String
}


struct ChallengeStart{
    let title: String
    let subTitle: String
    let imageName: String
}


struct Mood{
    let title : String
    let imageName: String
}

struct Strings {
    struct Intro {
        static let collectionViewPages: [Page] = [
            Page(imageName: images.introFestivities, title: "Welcome to Uni(re)Cycle", description: "The app that helps you build sustainable habits."),
            Page(imageName: images.introChecklist, title: "Participate in challenges", description: "Complete sustainable challenges and earn sustainability points"),
            Page(imageName: images.introHavingFun, title: "Compete with friends", description: "Check your progress in a leaderboard and compare it with your friends"),
            Page(imageName: images.introWinners, title: "Earn valuable rewards", description: "Spend earned sustainability points on real-life rewards")
        ]
        
        static let registerButtonTitle = "CREATE AN ACCOUNT"
        static let signInButtonTitle = "I ALREADY HAVE AN ACCOUNT"
        static let completeRegistrationButtonTitle = "COMPLETE REGISTRATION"

        
        static let emailPlaceholder = "E-mail address"
        static let passwordPlaceholder = "Password"
        static let firstNamePlaceholder = "First name"
        static let secondNamePlaceholder = "Second name"

        static let logIn = "LOG IN"
        static let signUp = "SIGN UP WITH EMAIL"
        static let registerViewControllerTitle = "Sign up"
        static let registerDetailsViewControllerTitle = "Picture"
        static let passwordRequirments: [RegistrationRequirment] = [
            RegistrationRequirment(text: "Must be at least 8 characters", regex: "^.{8,}$"),
            RegistrationRequirment(text: "Must include at least one capital letter", regex: "[^A-Z]*[A-Z].*"),
            RegistrationRequirment(text: "Must include at least one number", regex: ".*[0-9].*"),
            RegistrationRequirment(text: "Can't contain spaces", regex: "^[^\n ]*$"),
        ]
        static let emailRequirments: [RegistrationRequirment] = [
            RegistrationRequirment(text: "Email adress must be an hva email", regex: "^[A-Za-z0-9._%+-]+(@hva|@ad\\.hva)\\.nl$"),
        ]
        
        static let verifactionTitle = "Check your mail"
        static let verifactionSubTitle = "We have sent a verification link with instructions"
        static let openMailTitle = "OPEN THE MAIL APP"
    }
    
    struct Challenge {
        
        //Strings for the infoIcon
        static let infoTitlePop_up = "Why this challenge?"
        static let infomessagePop_up = "<info implemented soon> "
        static let done = "Done"
        
        //Strings for the Button
        static let letsdoitButtonTitle = "LET'S DO IT"
        static let continueButtonTitle = "CONTINUE"
        static let pop_upTitleNoDays = "NO DAYS ARE SELECTED!"
        static let pop_upMessageNoDays = "To continue select atleast 1 day to start this challenge"
        static let pop_upTitleFirstStap = "You made the first step!"
        static let pop_upMessageFirstStap = "Thank you for choosing to help our planet. Check your progress under active tab"
        static let pop_upTitleAlready2Days = "OOOPS!, WE NOTICED THAT YOU ALREADY 2 ACTIVE CHALLENGES!!"
        static let pop_upMessageAlready2Days = "To start a new challenge atleast one active challenge has to be completed"
        
        //Strings for the Tips
        static let tipsTitle = "Tips"
        static let subTitle = "Learn more"
        static let chevronright = "chevron.right"
        static let leaffill = "leaf.fill"
        static let tipsMessage = "Start Incrementantally! \n \nUse Tupperwares! \n \nPrep for days! \n \nHave fun with it!"
        
        static let frequancyHeadTitle = "Frequency"
        
        static let difficultyBeginnener = "Beginner"
        static let difficultyIntermediate = "Intermediate"
        static let difficultyExpert = "Expert"
        static let difficultyAdvanced = "Advanced"
        
        static let mondayButton = "M"
        static let tuesdayButton = "T"
        static let wednesdayButton = "W"
        static let thursdayButton = "T"
        static let firdayButton = "F"
        static let saturdayButton = "S"
        static let sundayButton = "S"
        
        static let gram = "g"
        static let sp = "SP"
        
        static let ofCo2Saved = "of Co² saved"
        static let ofWasteSaved = "of waste saved"
        static let earned = "earned"
        

        static let categories: [ChallengeCategory] = [
            ChallengeCategory(name: "Food", imageName: "chall_food"),
            ChallengeCategory(name: "Circular", imageName: "chall_circular"),
            ChallengeCategory(name: "Shopping", imageName: "chall_shopping"),
            ChallengeCategory(name: "Quizzes", imageName: "chall_quiz"),
        ]
        
        static let categorieStart: [ChallengeStart] = [
            ChallengeStart(title: "",subTitle: "" , imageName: "waste_icon"),
            ChallengeStart(title: "", subTitle:"", imageName: "co2_icon"),
            ChallengeStart(title: "",subTitle:"" ,imageName: "sp_icon"),
        ]
        
        static let segmentTitles = ["BROWSE", "ACTIVE"]
        static let title = "Challenges"
    }
    
    struct Reward {
        static let title = "Rewards"
        static let filterButton = "Filter"
        static let applyButton = "APPLY FILTERS"
        static let claimButton = "CLAIM FOR 250 SP"
    }
    
    struct ActionLog {
        static let textField = "Tap here to write about your experience"
        static let logButton = "LOG IN ACTION"
        static let title = "What was your favourite part about"
        static let moodButtons: [Mood] = [
            Mood(title: "Excited", imageName: "smile"),
            Mood(title: "Neutral", imageName: "unamused"),
            Mood(title: "Tired", imageName: "tired")
        ]
    }
    
    struct Home {
        static let title = "Home"
        static let latestChallenge = "Latest challenge"
        static let progressTitle = "Welcome back Laco!"
        static let progressDescription = "You saved 10 KG of waste this month. Check your progress to see more detailed information."
        static let progressButton = "check progress"
        static let sp = "SP"
        static let leaderboard = "Leaderboard"
        static let thisWeek = "THIS WEEK"
        static let allTime = "ALL TIME"
        static let now = "NOW"
        static let popupTitle = "What’s SP?"
        static let popupText = "SP stands for Sustainability Points, It is the amount of points that you get for the sustainable actions that you carry out.\n\nWe calculate the SP’s through it’s environmental impact: a matrix that takes into account CO2 and Waste saved per number of days."
        static let checkProgress = "CHECK PROGRESS"
        static let amountWaste = "Amount of waste saved: "
        static let amountCo2 = "Amount of co2 saved: "
    }
}
