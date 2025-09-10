# My Todo🔥 

An Assesment task that serves as a todo list to track everyday activities. A push Notification to remind the user of the task.


## ✨ Requirements

- Any Operating System (ie. MacOS X, Linux, Windows)
- Any IDE with SDK installed (ie. IntelliJ, Android Studio, VSCode etc)
- A little knowledge of Flutter

## 🎬 Demo Video

[![Demo Video]] https://www.youtube.com/watch?v=OK74VBVgZAw

*Click the link above to watch the demo video*

## 📸 ScreenShots

 <img src="assets/ss/1.png" width="400">   <img src="assets/ss/2.png" width="400"> 
 <img src="assets/ss/3.png" width="400">  <img src="assets/ss/4.png" width="400"> 
 <img src="assets/ss/5.png" width="400">  <img src="assets/ss/6.png" width="400"> 

## 📁 Folder Structure

```
mytodo/
├── assets/
│   └── ss/
├── lib/
│   ├── main.dart
│   ├── models/
│   ├── screens/
│   ├── widgets/
├── pubspec.yaml
└── README.md
```

## 🏗️ Approach and Assumptions

### 📱 **Simulating Login and Sign Up**
The authentication system is simulated using local storage without a backend server:

- **Package Used**: `hive` and `crypto` for local data storage and password hashing
- **Sign Up Process**: User credentials (email, username, password) are stored locally using Hive database with SHA-256 password hashing for basic security
- **Login Process**: Credentials are validated against locally stored user data
- **Session Management**: Current user session is maintained using a global state manager
- **Assumptions**: 
  - No real server authentication required
  - All user data persists locally on the device
  - Password security uses basic hashing (SHA-256) for demonstration purposes

### 👥 **Multi-User Functionality**
The app supports multiple users on the same device through user switching:

- **User Storage**: Each user account is stored with a unique identifier (email)
- **User Switching**: Users can switch between accounts through the profile screen
- **Session Isolation**: Each user session is completely isolated with their own task data
- **Global State**: `AppGlobals` class manages current user and maintains list of all registered users
- **Implementation**: 
  ```dart
  // User switching through AuthRepository
  switchUser(User user) → Updates global current user
  ```

### 🔐 **Task Separation and User Identification**
Tasks are isolated per user through ownership validation:

- **Task Ownership**: Each task contains a `createdBy` field linking it to the user's email
- **Data Isolation**: `TaskRepository` filters tasks by current user's ID
- **Storage Strategy**: 
  - Tasks stored in separate Hive boxes per user
  - Format: `user_tasks_{userId}` for individual user task storage
- **Access Control**: All CRUD operations validate task ownership before execution
- **Implementation**:
  ```dart
  // Only current user's tasks are loaded
  getCurrentUserTasks() → Returns tasks where createdBy == currentUser.email
  ```

### 🔔 **Notification Approach (2 Minutes Before Deadline)**
Local notifications are implemented using `flutter_local_notifications` package:

- **Scheduling Strategy**: Automatic notification scheduling when tasks are created/updated
- **Timing**: Notifications trigger exactly 2 minutes before task due date
- **Platform Support**: 
  - **Android**: Uses `AndroidNotificationChannel` with exact timing
  - **iOS**: Configured with `DarwinNotificationDetails` and proper permissions
- **Smart Management**:
  - Notifications auto-cancel when tasks are completed/deleted
  - User switching cancels all previous notifications and reschedules for new user
  - Past due dates are ignored (no notification scheduled)
- **Technical Implementation**:
  ```dart
  // Automatic scheduling in TaskRepository
  scheduleTaskReminder(task) → Sets notification 2 minutes before dueDate
  cancelTaskReminder(taskId) → Removes notification when task completed
  ```

### 🗂️ **Data Architecture**
- **Local Storage**: Hive database for offline-first approach
- **State Management**: Stacked architecture with reactive ViewModels
- **Dependency Injection**: GetIt for service location and dependency management
- **Data Flow**: Repository pattern with clear separation between data and presentation layers

### ⚠️ **Key Assumptions**
- All data storage is local (no cloud synchronization)
- Multi-user refers to multiple accounts on same device, not across devices
- Notifications require app installation and user-granted permissions
- User credentials are stored with basic hashing (not production-level security)
- App assumes users will grant necessary notification permissions for deadline reminders

## ⚡ Functionality

- Add, edit, and delete todo items
- Long Press to Edit and Delete task
- Categorize tasks based on their categories
- Multiuser
- Mark tasks as completed or pending
- View all tasks in a list
- Persistent storage of todos
- Responsive UI for different devices

## 🚀 Future Improvements

- Work more on the calendar to show all task for each day
- A graph showing how the user is performing with task
- Sync todos with cloud storage
- Add user authentication with Firebase
- Dark mode support
- Improved animations and UI enhancements
- Export/import todo lists

## 🤓 Author(s)

**Olaifa Glory Israel** [![Twitter Follow](https://img.shields.io/x/follow/kxSplash?style=social)](https://x.com/kxSplash)

## 🔖 LICENCE

[WTFPL](http://www.wtfpl.net/about/)