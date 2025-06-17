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
    
    private var db = Firestore.firestore()
    
 
    func fetchClubs() {
        db.collection("clubs").getDocuments { snapshot, error in
            if let error = error {
                print("❌ Error fetching clubs: \(error.localizedDescription)")
                return
            }

            let documents = snapshot?.documents ?? []
            
            self.clubs = documents.compactMap { doc in
                try? doc.data(as: ClubModel.self)
            }
            
            // For each club, fetch its top baller
            for (index, club) in self.clubs.enumerated() {
                guard let clubId = club.id else { continue }
                
                self.db.collection("clubs").document(clubId)
                    .collection("ballers")
                    .order(by: "amount", descending: true)
                    .limit(to: 1)
                    .getDocuments { snapshot, error in
                        guard let doc = snapshot?.documents.first,
                              let baller = try? doc.data(as: ClubBaller.self) else { return }
                        
                        DispatchQueue.main.async {
                            self.clubs[index].topBaller = baller
                        }
                    }
            }
        }
    }

}
