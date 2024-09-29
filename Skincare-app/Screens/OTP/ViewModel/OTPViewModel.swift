//
//  OTPViewModel.swift
//  Skincare-app
//
//  Created by Apple on 29.09.24.
//

class OTPViewModel {
    private let otpService = OTPService.shared
    
    func otpCode(email: String, otpCode: String, completionError: @escaping (Error) -> Void) {
        let request = OTPModel.Request(email: email, otpCode: otpCode)
        otpService.otpCode(request: request) { result in
            switch result {
            case .success:
                print("OTP Code is true")
            case .failure(let error):
                completionError(error)
            }
        }
    }
}
