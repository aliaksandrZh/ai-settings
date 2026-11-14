---
name: azh-angular
description: Use when you work with .net to follow user preferences.
---

# Project Structure

The defined project structure is mandatory and must be followed exactly. Do not simplify, flatten, reorganize, or reduce nesting, even if a different structure seems more appropriate or less complex.

Files must always be created in their designated directories.

Empty directories may either:
- Be created with a `.gitkeep` file, or
- Be omitted until they are needed.

Omitting an empty directory does not allow changing the defined hierarchy once a file needs to be created.

```
root/
├── .gitignore
├── README.md
├── Taskfile.yml                     # Unified short commands for running the monorepo (task up, task migrate, task test)
├── backend/                         # .NET ecosystem
│   ├── src/                         # Backend source code
│   │   ├── Domain/                  # 1. Domain layer (Business core)
│   │   │   ├── Common/              # Base classes (Entity, ValueObject, Result)
│   │   │   │   └── Extensions/      # Domain extension methods
│   │   │   ├── Entities/            # Entities (Rich Domain Model, private set)
│   │   │   ├── ValueObjects/        # Value objects (Email, Money, Address, etc.)
│   │   │   ├── Enums/               # Domain enumerations
│   │   │   ├── Events/              # Domain Events
│   │   │   ├── Exceptions/          # Custom business exceptions
│   │   │   └── Repositories/        # Repository interfaces
│   │   │
│   │   ├── Application/             # 2. Application layer (Use Cases, CQRS)
│   │   │   ├── Common/              # Pipelines (Behaviors), pagination models
│   │   │   │   └── Extensions/      # Application-specific extensions
│   │   │   ├── Features/            # Vertical slices (Commands / Queries / Validators)
│   │   │   ├── Interfaces/          # Application service interfaces (IEmailService, ICurrentUserService)
│   │   │   └── DependencyInjection.cs # Registration of Application services in DI
│   │   │
│   │   ├── Infrastructure/          # 3. Infrastructure layer (DB, external services)
│   │   │   ├── Persistence/         # EF Core implementation
│   │   │   │   ├── Configurations/  # Fluent API table configurations (IEntityTypeConfiguration)
│   │   │   │   ├── Interceptors/    # Interceptors (Audit, Soft Delete)
│   │   │   │   ├── Migrations/      # Database migrations
│   │   │   │   ├── Repositories/    # Implementations of Domain repositories
│   │   │   │   ├── Seed/            # Initial database population (Data Seeding)
│   │   │   │   └── AppDbContext.cs  # Database context
│   │   │   ├── Identity/            # Identity / JWT / Auth integration
│   │   │   │   ├── Models/          # Authentication and token models
│   │   │   │   └── Services/        # JwtTokenGenerator, PasswordHasher, etc.
│   │   │   ├── Services/            # Implementations of infrastructure interfaces (Email, Storage)
│   │   │   └── DependencyInjection.cs # Registration of Infrastructure and EF Core services in DI
│   │   │
│   │   └── Api/                     # 4. Presentation layer (Entry Point)
│   │       ├── Endpoints/           # Minimal API Endpoints (grouped by features)
│   │       ├── Middleware/          # Global error handling (Global Exception Handler)
│   │       ├── Program.cs           # Entry point and DI container setup
│   │       ├── appsettings.json     # Environment configurations
│   │       └── appsettings.Development.json
│   │
│   ├── tests/                       # Internal backend tests
│   │   ├── Domain.UnitTests/        # Domain logic unit tests
│   │   ├── Application.UnitTests/   # Use Cases unit tests
│   │   ├── Api.IntegrationTests/    # Integration tests with a real DB (Testcontainers)
│   │   └── Architecture.Tests/      # Architectural tests (NetArchTest)
│   │
│   ├── Backend.slnx                 # Single backend solution build entry point
│   ├── global.json                  # .NET SDK version pinning
│   ├── Directory.Build.props        # Common project build settings (TargetFramework, Nullable, TreatWarningsAsErrors)
│   ├── Directory.Packages.props     # Centralized NuGet package version management (CPM)
│   └── docker-compose.yml           # Local infrastructure (DB, message brokers)
│
├── frontend/                        # Frontend ecosystem
│   ├── src/
│   └── package.json
│
└── tests/                           # External E2E tests (full stack: UI + API + DB)
    └── e2e/                         # Playwright / Cypress / etc.

```

# Architectural Guidelines & Conventions

This document outlines the core architectural rules, patterns, and development conventions for the backend ecosystem of the `azh` monorepo (.NET 10, Clean Architecture, Entity Framework Core).

## 1. Dependency Rule (The Core Principle)

The dependency rule is absolute: **Source code dependencies must point only inward**.

* **`Domain`**: The business core. It contains zero references to external libraries, frameworks, or databases (no Entity Framework, no ASP.NET Core).

* **`Application`**: Contains business use cases (CQRS commands/queries). It depends **only** on `Domain`.

* **`Infrastructure`**: Implements technical details (EF Core, JWT, external APIs). It depends on `Application` and implements its interfaces.

* **`Api`**: The presentation layer (Minimal API entry point). It depends on `Application` and `Infrastructure` solely for dependency injection composition in `Program.cs`.

*Enforced via architectural tests (`NetArchTest`) on CI/CD.*

## 2. Entity Framework Core & Configuration

To keep the persistence layer clean and decoupled:

* **Strictly Clean `OnModelCreating`**: Never bloat `protected override void OnModelCreating(ModelBuilder modelBuilder)` with inline entity configurations (e.g., `modelBuilder.Entity<User>(...)`). The `DbContext` must only call `builder.ApplyConfigurationsFromAssembly()`.

* **`IEntityTypeConfiguration<T>`**: Every entity must have a dedicated configuration class implementing `IEntityTypeConfiguration<TEntity>` placed under `Infrastructure/Persistence/Configurations/` right next to the corresponding persistence mapping logic.

* **Migrations**: Database migrations are strictly managed and stored within `Infrastructure/Persistence/Migrations`. Automatic runtime migrations on production environments are prohibited.

## 3. Data Models & CQRS

* **Rich Domain Models**: Avoid anemic domain models where entities are mere data bags with public setters. Domain entities must protect their invariants by having private setters (`private set`) and exposing explicit business methods to alter their state (e.g., `order.Cancel()`).

* **CQRS Queries Optimization**: All read operations in CQRS queries must use `.AsNoTracking()` to avoid change-tracking overhead. Use explicit `.Select(x => new Dto(...))` projections to fetch only the required columns from the database, preventing over-fetching.

## 4. API (Minimal API & Vertical Slices)

* **Minimal API over Controllers**: Avoid bulky traditional controllers that turn into god-objects. Use Minimal API endpoints (`Endpoints/`) grouped by features to reduce boilerplate and keep routing declarations clean and readable.

* **Vertical Slices Integration**: Each endpoint delegates execution directly to MediatR handlers (`Commands` or `Queries`), keeping the presentation layer as thin as possible.

## 5. Coding & Naming Conventions

* **No Magic Values**: Magic strings and numbers are strictly prohibited in the codebase. All configurations, connection strings, feature flags, and thresholds must be loaded via `appsettings.json` using the Options pattern (`IOptions<T>`) or, in rare cases, centralized static collection classes.

* **Interface Naming Prefix**: All interfaces must strictly follow the PascalCase naming convention with a leading `I` prefix (e.g., `IUserRepository`, `IEmailService`).

# Always check the available skills and MCPs, invoke the relevant ones, and follow their guidelines.
* If they conflict with the user's preferences, ask the user which takes priority.