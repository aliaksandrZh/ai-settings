# Project Structure

Preserve the established solution structure and architectural boundaries. Do not arbitrarily reorganize, flatten, or redesign the project.

```text
root/                                          # Monorepo root
├── .gitignore                                 # Git exclusions
├── README.md                                  # Project documentation
├── Taskfile.yml                               # Unified monorepo commands
├── backend/                                   # .NET ecosystem
│   ├── src/                                   # Backend source projects
│   │   ├── Domain/                            # Core business model
│   │   │   ├── Common/                        # Shared domain primitives
│   │   │   │   └── Extensions/                # Domain extension methods
│   │   │   ├── Entities/                      # Domain entities
│   │   │   ├── ValueObjects/                  # Domain value objects
│   │   │   ├── Enums/                         # Domain enumerations
│   │   │   ├── Events/                        # Domain events
│   │   │   ├── Exceptions/                    # Business exceptions
│   │   │   └── Repositories/                  # Domain repository contracts
│   │   │
│   │   ├── Application/                       # Application use cases
│   │   │   ├── Common/                        # Shared application functionality
│   │   │   │   └── Extensions/                # Application extension methods
│   │   │   ├── Features/                      # Application features and use cases
│   │   │   ├── Interfaces/                    # Shared application contracts
│   │   │   └── DependencyInjection.cs         # Application service registration
│   │   │
│   │   ├── Infrastructure/                    # Main application infrastructure
│   │   │   ├── Common/                        # Shared infrastructure functionality
│   │   │   │   └── Extensions/                # Infrastructure extension methods
│   │   │   ├── Persistence/                   # Main application data access
│   │   │   │   ├── Configurations/            # EF Core entity configurations
│   │   │   │   ├── Interceptors/              # EF Core interceptors
│   │   │   │   ├── Migrations/                # Database migrations
│   │   │   │   ├── Repositories/              # Domain repository implementations
│   │   │   │   ├── Seed/                      # Initial database data
│   │   │   │   └── AppDbContext.cs            # Main application DbContext
│   │   │   ├── Services/                      # Infrastructure service implementations
│   │   │   └── DependencyInjection.cs         # Infrastructure service registration
│   │   │
│   │   ├── Auth/                              # Reusable authentication module
│   │   │   ├── Common/                        # Shared authentication functionality
│   │   │   │   └── Extensions/                # Authentication extension methods
│   │   │   ├── Identity/                      # ASP.NET Core Identity integration
│   │   │   ├── Tokens/                        # Access and refresh token functionality
│   │   │   ├── Persistence/                   # Authentication-specific persistence
│   │   │   ├── Azh.Auth.csproj                # Authentication class library
│   │   │   └── DependencyInjection.cs         # Authentication service registration
│   │   │
│   │   ├── Api/                               # HTTP API host
│   │   │   ├── Common/                        # Shared API functionality
│   │   │   │   └── Extensions/                # API-specific extension methods
│   │   │   ├── Endpoints/                     # Minimal API endpoints
│   │   │   ├── Dto/                           # HTTP request and response models
│   │   │   ├── Middleware/                    # HTTP middleware
│   │   │   ├── Program.cs                     # API composition root and pipeline
│   │   │   ├── appsettings.json               # Base API configuration
│   │   │   └── appsettings.Development.json   # Development API configuration
│   │   │
│   │   └── Worker/                            # Optional background worker host
│   │       └── Program.cs                     # Worker composition root
│   │
│   ├── tests/                                 # Backend automated tests
│   │   ├── Domain.UnitTests/                  # Domain unit tests
│   │   ├── Application.UnitTests/             # Application unit tests
│   │   ├── Api.IntegrationTests/              # API integration tests
│   │   └── Architecture.Tests/                # Architecture boundary tests
│   │
│   ├── Backend.slnx                           # Backend solution
│   ├── global.json                            # .NET SDK version pinning
│   ├── Directory.Build.props                  # Shared MSBuild properties
│   ├── Directory.Packages.props               # Central NuGet package versions
│   └── docker-compose.yml                     # Local infrastructure services
│
├── frontend/                                  # Frontend application
│   ├── src/                                   # Frontend source code
│   └── package.json                           # Frontend dependencies and scripts
│
└── tests/                                     # Cross-application tests
    └── e2e/                                   # End-to-end tests
```

The tree describes the default organization, not an exhaustive list of permitted directories. Optional projects and unused directories must not be created prematurely.

## Directory Rules

- Create directories and projects only when required by actual implementation.
- Never create empty directories or `.gitkeep` files.
- The directory tree is a structural guide, not an exhaustive allowlist.
- Additional directories are allowed when they represent a clear responsibility and preserve architectural boundaries.
- Do not treat a directory absent from the tree as an architectural violation by itself.
- Do not introduce new architectural layers or root-level project directories without approval.
- Avoid arbitrary catch-all directories such as `Utils`, `Misc`, or `Managers`.

### Directory Consistency

Use consistent naming and nesting conventions across projects and layers.

For example:
- `Domain/Common/Extensions/`
- `Application/Common/Extensions/`
- `Infrastructure/Common/Extensions/`
- `Auth/Common/Extensions/`
- `Api/Common/Extensions/`

Apply the same principle to other organizational categories, such as `Helpers` and `Constants`.

- Keep naming and nesting consistent when the same category is used in multiple projects.
- Do not create empty directories for symmetry.
- A category only needs to exist where it has a real purpose.
- Project responsibilities take precedence over structural symmetry.
- Never put extension methods inside `Services/`.
