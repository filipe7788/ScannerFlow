//
//  File.swift
//  
//
//  Created by Filipe da Cruz Ribeiro on 15/11/21.
//

import Foundation
@testable import ScannerFlow

extension ScannerFlow.DataSource {
    static func mock() -> ScannerFlow.DataSource.UserInfo {
        return .init(
            recognizedText: [
                "REGISTRO",
                "GERAL",
                "1939492011-2",
                "JOSE DA SILVA E ADELAIDE SOUSA",
                "DA SILVA",
                "23/07/1980",
                "615243013-53",
                "VIA-02", "DO co",
                "VALIDA EM TODO O TERRITORIO NACIONAL",
                "DATA DE EXPEDIÇAO10/02/2011",
                "NOME JAAZIEL SOUSA DA SILVA",
                "FILIAÇÃO", "NATURALIDADE",
                "DATA DE NASCIMENTO",
                "BACABAL - MA",
                "DOC ORIGEM",
                "NASC. N.37.119 FLS. 168 LIV.25-A",
                "CPF",
                "SAD LUIS-MA",
                "P-242",
                "ASSINATURA DO DIRETOR",
                "0 To 70 LEI N°7.116 DE 29/08/83",
                "NOD TRINTA AROUCKE",
                "V - DO",
                "os o to"
            ]
        )
    }
}
