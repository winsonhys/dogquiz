# dogquiz

DogQuiz is an iOS application that provides users with a fun and interactive way to learn about different dog breeds. The app fetches random dog breeds and images, allowing users to test their knowledge through quizzes.





## Architecture

The DogQuiz app follows a modular architecture with a focus on separation of concerns. Here's a brief overview of the architecture:

- **App Architecture**: It mainly uses the MV pattern with dependency injection for testing assistance.

- **Services**: The `Services` directory contains classes responsible for fetching data from external APIs. This includes:
  - `DogBreedService`: Manages fetching and parsing of dog breed data.
  - `DogImageService`: Handles fetching random dog images.
  - For mock implementations, I chose to subclass instead of using a protocol due to the simplicity of the service.

- **Network**: The `Network` directory contains the network client used by the services to make API requests.

- **Utils**: Utility classes and extensions that provide common functionality used across the app.


- **Quiz**: Contains the logic and UI components related to the quiz functionality.

## Folder Structure

Withn `Quiz` folder itself, there are several nested folders. These are explained below.

- **Entities**: Contains SwiftData data models. Used to store score history
  
- **Screens**: Each subfolder's main file is a screen.
  
- **Views**: UI that's used to compose a `Screen`
  
- **Models**: Data models used in the app, but not to interface with SwiftData

Dependencies are also implied from the folder structure. For example, since `QuizView` is dependent on `QuestionView`, `Question` is nested under `Quiz`

## Setup Instructions

1. **Clone the Repository**: 
   ```bash
   git clone <repository-url>
   cd dogquiz
   ```

2. **Open the Project**: Open the `dogquiz.xcodeproj` file in Xcode.

3. **Install Dependencies**: Ensure you have all necessary dependencies installed. This project uses Swift Package Manager for dependency management.

4. **Run the App**: Select a simulator or a connected device and click the Run button in Xcode.

## Testing

The project includes mock implementations for the services, allowing for easy testing of components that depend on `DogBreedService` and `DogImageService`. You can find these mocks in the `Services` directory:

- `MockDogBreedService`
- `MockDogImageService`

These mocks can be used in unit tests to simulate the behavior of the actual services without making network calls.

## Q&A
Q: Did I test every single function?
<br>A: No. I attempted this like an engineering project. Therefore, I only tested things that are hard to test by hand and easy to miss out.

Q: Why did I use XCTest instead of Testing
<br>
A: Familarity.

Q: Did I use AI?
<br>
A: Yes. I attempted it like an engineering project.
