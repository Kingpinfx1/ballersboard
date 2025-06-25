//
//  AuthViewModel.swift
//  ballersboard
//
//  Created by kingpin on 6/17/25.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore


@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var clubs: [ClubModel] = []
    @Published var errorMessage: String?
    private var db = Firestore.firestore()
    
    
    // MARK: FETCH CLUBS
    
    func fetchClubs() async {
        do {
            var fetchedClubs: [ClubModel] = []
            
            let snapshot = try await db.collection("clubs").getDocuments()
            
            for document in snapshot.documents {
                if var club = try? document.data(as: ClubModel.self),
                   let clubId = club.id {
                    
                    let ballerSnapshot = try await db.collection("clubs")
                        .document(clubId)
                        .collection("ballers")
                        .order(by: "amount", descending: true)
                        .limit(to: 1)
                        .getDocuments()

                    if let topDoc = ballerSnapshot.documents.first {
                        club.topBaller = try? topDoc.data(as: ClubBaller.self)
                    }
                    
                    fetchedClubs.append(club)
                }
            }

            // ✅ Sort by top baller amount (descending). Clubs with no top baller go to the bottom.
            self.clubs = fetchedClubs.sorted {
                let amount1 = $0.topBaller?.amount ?? 0
                let amount2 = $1.topBaller?.amount ?? 0
                return amount1 > amount2
            }

        } catch {
            print("❌ Error fetching clubs: \(error.localizedDescription)")
        }
    }

    // MARK: SIGNUP CLUBS
    func signUpClub(email: String, password: String, club: ClubModel) async -> Bool {
        do {
            // Step 1: Sign up with Firebase Auth
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let userID = authResult.user.uid

            // Step 2: Save club to Firestore
            var newClub = club
            newClub.id = userID // use UID as document ID
            try db.collection("clubs").document(userID).setData(from: newClub)

            return true
        } catch {
            self.errorMessage = error.localizedDescription
            return false
        }
    }

}
