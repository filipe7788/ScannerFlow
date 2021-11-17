public enum ScannerFlow {}

/*
    ScannerFlowDelegate
        Delegate to be implemented by application
        to receive and handle text recognition
*/

public protocol ScannerFlowDelegate {
    func handleReconizedText(from text: [String])
}
