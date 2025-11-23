# HRIS App - Development Plan

## Project Overview

**Project Name:** Hantera (HRIS Application)  
**Platform:** Flutter (Cross-platform: iOS, Android, Web)  
**Architecture:** Clean Architecture + BLoC State Management  
**Status:** In Development  
**Scope:** Exclude Payroll Module  

---

## Development Strategy

### Phase 1: Foundation (Complete ✅)
- [x] Auth feature (Sign In, Sign Up, Home Page)
- [x] Clean Architecture setup with BLoC
- [x] Dependency Injection (GetIt service locator)
- [x] Local persistence (Hive)
- [x] Mock Remote Datasource
- [x] Theme & UI Components

### Phase 2: Core HRIS Modules (In Progress)
- [ ] Employee Management
- [ ] Attendance & Time Tracking
- [ ] Leave Management
- [ ] Organization Structure
- [ ] Dashboard & Notifications

### Phase 3: Backend Integration (Pending Backend Ready)
- [ ] HTTP Client Layer (Dio)
- [ ] Remote API Integration
- [ ] Caching Strategy
- [ ] Error Handling & Retry Logic

### Phase 4: Polish & Optimization
- [ ] Navigation & Routing (GoRouter)
- [ ] Testing (Unit, Widget, Integration)
- [ ] Performance Optimization
- [ ] Release Build

---

## Architecture Pattern

### Clean Architecture Layers

```
Presentation Layer
├── BLoC (State Management)
├── Pages (Screens)
└── Widgets (Reusable Components)
        ↓
Domain Layer
├── Entities (Business Models)
├── Repositories (Abstract)
└── Use Cases (Business Logic)
        ↓
Data Layer
├── Datasources (Local & Remote)
├── Models (Data Transfer Objects)
└── Repositories (Implementation)
```

### Key Principles
1. **Separation of Concerns** - Each layer has specific responsibility
2. **Dependency Inversion** - High-level modules depend on abstractions
3. **Testability** - All dependencies are injectable
4. **Modularity** - Features are independent and reusable
5. **Scalability** - Easy to add new features following established patterns

---

## Feature Module Structure

Every feature follows this standardized structure:

```
features/
└── [feature_name]/
    ├── data/
    │   ├── datasources/
    │   │   ├── [feature]_local_data_source.dart (abstract)
    │   │   ├── [feature]_local_data_source_impl.dart
    │   │   ├── [feature]_remote_data_source.dart (abstract)
    │   │   └── [feature]_remote_data_source_impl.dart
    │   ├── models/
    │   │   └── [model]_model.dart (extends entity)
    │   └── repositories/
    │       └── [feature]_repository_impl.dart
    ├── domain/
    │   ├── entities/
    │   │   └── [entity].dart
    │   ├── repositories/
    │   │   └── [feature]_repository.dart (abstract)
    │   └── usecases/
    │       └── [use_case].dart
    └── presentation/
        ├── bloc/
        │   ├── [feature]_bloc.dart
        │   ├── [feature]_event.dart
        │   └── [feature]_state.dart
        ├── pages/
        │   └── [page_name]_page.dart
        └── widgets/
            └── [widget_name].dart
```

### Implementation Pattern

**1. Define Entity (Domain Layer)**
```dart
class Employee extends Equatable {
  final String id;
  final String name;
  final String email;
  final String department;
}
```

**2. Create Models (Data Layer)**
```dart
class EmployeeModel extends Employee {
  const EmployeeModel({...});
  
  factory EmployeeModel.fromJson(Map<String, dynamic> json) => ...
  Map<String, dynamic> toJson() => ...
}
```

**3. Abstract Datasources**
```dart
// Local (Hive/Cache)
abstract class EmployeeLocalDataSource {
  Future<List<EmployeeModel>> getEmployees();
  Future<void> cacheEmployees(List<EmployeeModel> employees);
}

// Remote (API/Mock)
abstract class EmployeeRemoteDataSource {
  Future<List<EmployeeModel>> fetchEmployees();
}
```

**4. Repository Implementation (Bridge)**
```dart
class EmployeeRepositoryImpl extends EmployeeRepository {
  Future<Either<Failure, List<Employee>>> getEmployees() async {
    try {
      final remoteEmployees = await remoteDataSource.fetchEmployees();
      await localDataSource.cacheEmployees(remoteEmployees);
      return Right(remoteEmployees);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
```

**5. Use Cases (Domain Logic)**
```dart
class GetEmployees extends UseCase<List<Employee>, NoParams> {
  final EmployeeRepository repository;
  
  @override
  Future<Either<Failure, List<Employee>>> call(NoParams params) {
    return repository.getEmployees();
  }
}
```

**6. BLoC (State Management)**
```dart
class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final GetEmployees getEmployees;
  
  EmployeeBloc({required this.getEmployees}) : super(EmployeeInitial()) {
    on<GetEmployeesEvent>(_onGetEmployees);
  }
  
  Future<void> _onGetEmployees(GetEmployeesEvent event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoading());
    final result = await getEmployees(NoParams());
    result.fold(
      (failure) => emit(EmployeeFailure(failure.message)),
      (employees) => emit(EmployeeLoaded(employees)),
    );
  }
}
```

---

## Module Development Plan

### 1. Employee Management
**Features:**
- List all employees with pagination
- View employee profile & details
- Search employees by name/ID
- Edit employee information
- Add new employee

**Mock Data:**
- 50+ sample employee records
- Multiple departments
- Various designations & roles

**Entities:**
- Employee (id, name, email, phone, department, designation, hireDate, profilePicture)

**Use Cases:**
- GetAllEmployees
- GetEmployeeById
- UpdateEmployee
- CreateEmployee
- SearchEmployees

---

### 2. Attendance & Time Tracking
**Features:**
- Clock in/out with timestamp
- View attendance history
- Monthly attendance report
- Mark attendance manually (admin only)
- Late arrival notifications

**Mock Data:**
- Daily attendance records for 30 days
- Timestamps with location data
- Status: Present, Absent, Late, Leave

**Entities:**
- Attendance (id, employeeId, date, checkIn, checkOut, status, location)

**Use Cases:**
- ClockIn
- ClockOut
- GetAttendanceHistory
- GetMonthlyAttendanceReport
- MarkAttendance

---

### 3. Leave Management
**Features:**
- Request leave with reason & dates
- View leave balance
- Leave request history
- Approval workflow (Manager/Admin)
- Leave calendar view

**Mock Data:**
- Various leave types (Sick, Vacation, Personal, Maternity, etc.)
- Leave balances per employee
- Pending & approved requests

**Entities:**
- Leave (id, employeeId, type, startDate, endDate, reason, status, approverId)
- LeaveBalance (id, employeeId, type, allocated, used, remaining)
- LeaveApproval (id, leaveId, approverId, status, comment)

**Use Cases:**
- ApplyForLeave
- GetLeaveBalance
- GetLeaveHistory
- ApproveLeave
- RejectLeave

---

### 4. Organization Structure
**Features:**
- View organization hierarchy
- View department structure
- View team members
- View reporting manager
- Organization directory

**Mock Data:**
- Departments: HR, Engineering, Sales, Finance, Marketing
- Team hierarchy with reporting relationships
- Manager assignments

**Entities:**
- Department (id, name, description, managerId)
- Team (id, name, departmentId, managerId)
- OrganizationHierarchy (employeeId, managerId, departmentId, teamId)

**Use Cases:**
- GetOrganizationHierarchy
- GetDepartmentStructure
- GetTeamMembers
- GetEmployeeManager
- GetReportees

---

### 5. Dashboard & Notifications
**Features:**
- Dashboard overview (user statistics, pending tasks)
- Notifications (leave approvals, attendance alerts)
- Quick actions (Clock in/out, Request leave)
- User profile management

**Mock Data:**
- Dashboard summaries
- Notification queue
- User preferences

**Entities:**
- Notification (id, userId, type, title, message, read, timestamp)
- DashboardSummary (pendingLeaves, checkedIn, attendanceRate, etc.)

**Use Cases:**
- GetDashboardSummary
- GetNotifications
- MarkNotificationAsRead

---

## Dependency Injection Setup

### Service Locator Registration Pattern

All features register dependencies in `service_locator.dart` following this order:

```dart
// 1. Data Sources (External dependencies first)
sl.registerLazySingleton<[Feature]LocalDataSource>(
  () => [Feature]LocalDataSourceImpl(hiveBox: sl()),
);

sl.registerLazySingleton<[Feature]RemoteDataSource>(
  () => [Feature]RemoteDataSourceImpl(),
);

// 2. Repositories (Depends on datasources)
sl.registerLazySingleton<[Feature]Repository>(
  () => [Feature]RepositoryImpl(
    localDataSource: sl(),
    remoteDataSource: sl(),
  ),
);

// 3. Use Cases (Depends on repositories)
sl.registerLazySingleton(() => GetAllEmployees(sl()));
sl.registerLazySingleton(() => UpdateEmployee(sl()));

// 4. BLoCs (Depends on use cases) - Factory pattern
sl.registerFactory(
  () => [Feature]Bloc(
    getAll: sl(),
    update: sl(),
  ),
);
```

### Initialization Order in `main.dart`
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.init(); // Initialize all dependencies
  runApp(const MyApp());
}
```

---

## Mock Data Strategy

### Current Implementation
- **Auth**: Hardcoded test credentials in `AuthRemoteDataSourceImpl`
- **Local Storage**: Hive for persistent mock data

### New Features Mock Data
1. **Approach**: Create `MockData` class with static sample data
2. **Location**: `/lib/core/mocks/mock_data.dart`
3. **Data Generation**: Use consistent, realistic sample data
4. **Storage**: Initially stored in models, later in Hive

### Example Mock Data Structure
```dart
class MockData {
  static final List<EmployeeModel> employees = [
    EmployeeModel(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      department: 'Engineering',
      // ...
    ),
    // ... more employees
  ];
  
  static final List<AttendanceModel> attendanceRecords = [
    // ... mock attendance
  ];
}
```

### Switching from Mock to Remote
```dart
// In service_locator.dart - use environment variable
const bool useMockData = String.fromEnvironment('MOCK_DATA', defaultValue: 'true') == 'true';

if (useMockData) {
  sl.registerLazySingleton<EmployeeRemoteDataSource>(
    () => EmployeeRemoteDataSourceMock(),
  );
} else {
  sl.registerLazySingleton<EmployeeRemoteDataSource>(
    () => EmployeeRemoteDataSourceImpl(httpClient: sl()),
  );
}
```

---

## HTTP Client Setup (Phase 3)

### Dio Configuration
```dart
// /lib/core/network/http_client.dart
class HttpClient {
  final Dio _dio = Dio();
  
  HttpClient() {
    _dio.options.baseUrl = 'https://api.example.com';
    _dio.options.connectTimeout = Duration(seconds: 30);
    _dio.interceptors.add(LoggingInterceptor());
    _dio.interceptors.add(AuthInterceptor());
  }
  
  Future<Response> get(String endpoint) => _dio.get(endpoint);
  Future<Response> post(String endpoint, data) => _dio.post(endpoint, data: data);
}
```

### Remote Datasource Implementation (When Backend Ready)
```dart
class EmployeeRemoteDataSourceImpl extends EmployeeRemoteDataSource {
  final HttpClient httpClient;
  
  EmployeeRemoteDataSourceImpl({required this.httpClient});
  
  @override
  Future<List<EmployeeModel>> fetchEmployees() async {
    final response = await httpClient.get('/employees');
    return (response.data as List)
        .map((e) => EmployeeModel.fromJson(e))
        .toList();
  }
}
```

---

## Navigation & Routing

### Route Structure
```
/
├── /auth
│   ├── /sign-in
│   └── /sign-up
├── /home
├── /employees
│   ├── /list
│   ├── /:id (profile)
│   └── /edit/:id
├── /attendance
│   ├── /clock-in
│   └── /history
├── /leaves
│   ├── /request
│   ├── /balance
│   └── /history
└── /organization
    ├── /structure
    └── /team
```

### Implementation (GoRouter - To be added)
```dart
final goRouter = GoRouter(
  routes: [
    GoRoute(path: '/auth/sign-in', builder: (context, state) => SignInPage()),
    GoRoute(path: '/home', builder: (context, state) => HomePage()),
    GoRoute(path: '/employees', builder: (context, state) => EmployeeListPage()),
    // ... more routes
  ],
);
```

---

## Testing Strategy

### Unit Tests
- Test each use case with mock repository
- Test repository with mock datasources
- Test error handling and edge cases

### Widget Tests
- Test pages with mock BLoC
- Test widgets with various states
- Test navigation and interactions

### Integration Tests
- Test complete user flows
- Test data persistence
- Test error scenarios

### Mock Data for Testing
```dart
class MockEmployeeRepository extends Mock implements EmployeeRepository {}
class MockGetAllEmployees extends Mock implements GetAllEmployees {}
```

---

## Error Handling

### Exception Types
```dart
// /lib/core/error/exception.dart
class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}

class ServerException implements Exception {
  final String message;
  final int? statusCode;
  ServerException(this.message, {this.statusCode});
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}
```

### Failure Types
```dart
// /lib/core/error/failure.dart
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure(String message, {this.statusCode}) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}
```

### Error Handling in BLoC
```dart
result.fold(
  (failure) {
    if (failure is CacheFailure) {
      emit(EmployeeFailure('Data not available offline'));
    } else if (failure is ServerFailure) {
      emit(EmployeeFailure('Server error: ${failure.message}'));
    }
  },
  (employees) => emit(EmployeeLoaded(employees)),
);
```

---

## Additional Dependencies to Add

### Current
- `flutter_bloc: ^8.1.6`
- `equatable: ^2.0.5`
- `get_it: ^7.7.0`
- `bloc: ^8.1.4`
- `dartz: ^0.10.1`
- `hive: ^2.2.3`
- `hive_flutter: ^1.1.0`
- `path_provider: ^2.1.3`

### To Add (Phase 2-3)
- `dio: ^5.3.0` - HTTP client for API calls
- `go_router: ^13.0.0` - Navigation & routing
- `flutter_dotenv: ^5.1.0` - Environment variables
- `json_serializable: ^6.7.0` - JSON serialization (code generation)
- `faker: ^2.1.0` - Generate fake data for testing
- `mockito: ^5.4.0` - Mocking for tests
- `flutter_test` - Widget testing (built-in)

### Optional (Phase 4+)
- `firebase_messaging: ^14.6.0` - Push notifications
- `google_maps_flutter: ^2.2.0` - Location tracking
- `share_plus: ^7.0.0` - Share functionality
- `image_picker: ^1.0.0` - Image selection
- `cached_network_image: ^3.3.0` - Image caching

---

## Development Timeline

### Week 1-2: Employee Management
- [ ] Create Employee entity & models
- [ ] Implement LocalDataSource (Hive)
- [ ] Implement RemoteDataSource (Mock)
- [ ] Create Repository & Use Cases
- [ ] Build BLoC & Pages
- [ ] UI implementation with widgets

### Week 3: Attendance & Time Tracking
- [ ] Entity & models setup
- [ ] Datasources & repository
- [ ] Use cases & BLoC
- [ ] UI Pages (Clock in, History, Report)

### Week 4: Leave Management
- [ ] Complex entity relationships
- [ ] Approval workflow logic
- [ ] Use cases for requests & approvals
- [ ] Multi-step UI flows

### Week 5: Organization & Dashboard
- [ ] Hierarchical data handling
- [ ] Dashboard aggregation logic
- [ ] Notification system
- [ ] Quick actions UI

### Week 6: Navigation & Cleanup
- [ ] GoRouter setup & implementation
- [ ] Navigation tests
- [ ] Code cleanup & optimization
- [ ] Remove debug logs

### Week 7-8: Backend Integration (When ready)
- [ ] HTTP client setup
- [ ] Remote datasource implementations
- [ ] Replace mock with real API
- [ ] Caching strategy
- [ ] Error handling refinement

---

## Code Quality Standards

### Naming Conventions
- **Classes**: `PascalCase` (e.g., `EmployeeBloc`)
- **Methods/Variables**: `camelCase` (e.g., `getEmployees()`)
- **Constants**: `camelCase` (e.g., `const maxRetries = 3`)
- **Files**: `snake_case` (e.g., `employee_bloc.dart`)

### File Organization
- One class per file (except enums/related types)
- Alphabetical ordering of imports
- Group imports: dart, flutter, packages, relative

### Comments & Documentation
- Document public APIs
- Explain complex logic
- Include TODO/FIXME for future work
- Remove debug print statements in production

### BLoC Naming
- **Events**: `{Action}Event` (e.g., `GetEmployeesEvent`)
- **States**: `{Action}{Result}State` (e.g., `EmployeeLoaded`, `EmployeeFailure`)
- **Handlers**: `_on{Event}` (e.g., `_onGetEmployees`)

---

## Git Workflow

### Branch Naming
- Feature: `feature/employee-management`
- Bugfix: `bugfix/auth-crash`
- Refactor: `refactor/dependency-injection`

### Commit Messages
```
feat: add employee list feature
fix: resolve null pointer in employee bloc
refactor: simplify repository pattern
docs: update architecture plan
test: add unit tests for employee use case
```

### Pull Request Process
1. Create feature branch from `develop`
2. Implement feature with modular approach
3. Ensure all tests pass
4. Create PR with description
5. Code review
6. Merge to `develop`
7. Merge `develop` to `main` for release

---

## Success Criteria

- [x] Auth feature complete with clean architecture
- [ ] All 4 main features implemented with mock data
- [ ] 80%+ code coverage with tests
- [ ] Zero breaking changes when switching to remote API
- [ ] Consistent module structure across all features
- [ ] Clear separation of concerns (Clean Architecture)
- [ ] Responsive UI on mobile, tablet, and web
- [ ] Offline support for critical features
- [ ] All features documented

---

## Contact & Support

- **Questions about architecture**: Refer to Clean Architecture + BLoC patterns
- **Adding new features**: Follow feature module structure template
- **Backend integration**: Use HTTP client layer when ready
- **Mock data**: Extend `MockData` class with additional samples

---

**Last Updated**: November 14, 2025
