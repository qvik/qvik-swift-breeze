//
// Created by Andriy Druk on 28.06.2020.
//
import Foundation
import BreezeCore

public class SSLHelper {

    public static func setupCert(basePath: String) {
        // Setup SSL
        let caPath = basePath + "/cacert.pem"
        setenv("URLSessionCertificateAuthorityInfoFile", caPath, 1)
        setenv("URLSessionCertificateAuthorityInfoFile", "INSECURE_SSL_NO_VERIFY", 1)
    }
}

