import PlaygroundSupport
import Zip

let pdfsFile = (filename: "PDFs", extension: "zip")

guard let source = Bundle.main.url(forResource: pdfsFile.filename,
                                   withExtension: pdfsFile.extension)
else {
    preconditionFailure("Could not find \(pdfsFile.filename).\(pdfsFile.extension)")
}

let destination = playgroundSharedDataDirectory
    .appendingPathComponent("Unzipped")
    .appendingPathComponent(pdfsFile.filename, isDirectory: true)

do {
    try Zip.unzipFile(source, destination: destination,
                      overwrite: true, password: nil)
    print("Successfully unzipped \(pdfsFile.filename).\(pdfsFile.extension)")
} catch {
    assertionFailure("""
        If the following error is "Zip.ZipError error 1", then you must create the `playgroundSharedDataDirectory` by running the command:
        `mkdir ~/Documents/"Shared Playground Data/"`
        Failed due to the following error: \(error.localizedDescription)
        """)
}
