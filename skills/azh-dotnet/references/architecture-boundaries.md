# Architecture Boundaries

Follow Clean Architecture and preserve the established project boundaries. Inspect existing code and conventions before deciding where new code belongs.

## Project Responsibilities

| Project | Responsibility |
|---|---|
| Domain | Business entities, value objects, domain events, exceptions, repository contracts |
| Application | Application use cases, CQRS, handlers, validators, application contracts |
| Infrastructure | Main application persistence, repository implementations, external integrations |
| Auth | Reusable authentication functionality and token management |
| Api | HTTP endpoints, DTOs, middleware, HTTP-specific configuration |
| Worker | Background processing and worker-specific composition |

### Dependency Boundaries

- Domain has no dependencies on other application projects.
- Application depends on Domain.
- Infrastructure depends on Application and Domain.
- Api references the projects required to expose and compose the application.
- Worker references only the projects required for its responsibilities.
- Auth is reusable by Api, Worker, and other host applications.
- Auth must not depend on Api or another specific host.
- Avoid circular project dependencies.
- Do not introduce project references without a concrete requirement.

## Code Placement

Place code according to its responsibility and the project that owns it.

### Domain

Contains business concepts and domain contracts:
- Entities and value objects.
- Domain events and exceptions.
- Repository interfaces.
- Domain-specific extensions and shared primitives.

Domain must not contain infrastructure, database, HTTP, or framework-specific implementation details.

### Application

Contains application-level behavior:
- Use cases and feature orchestration.
- Commands, queries, handlers, and validators.
- Application-specific models and contracts.
- Contracts required by application use cases.

`Application/Interfaces/` is for shared application contracts, not a mandatory location for every interface.

Keep use-case-specific contracts close to the use case that owns them.

### Infrastructure

Contains implementations of technical concerns required by the main application:
- EF Core persistence and database configuration.
- Implementations of Domain repository contracts.
- External service integrations.
- Infrastructure-specific services and extensions.

Do not put HTTP-specific functionality in Infrastructure.

### Api

Contains HTTP-specific functionality:
- Minimal API endpoints.
- HTTP request and response DTOs.
- Middleware and filters.
- HTTP-specific current-user and claims access.
- JWT Bearer configuration and validation.
- CORS and HTTP authorization configuration.
- Cookie creation and handling.

`Api/Dto/` is a valid location for HTTP contracts. HTTP DTOs do not need to be moved into Application merely to match a generic directory convention.

Endpoints should handle HTTP concerns and delegate application or module operations to the appropriate services. Avoid putting substantial business or orchestration logic directly in endpoint handlers.

## Dependency Injection and Composition

Each project owns registration of its services:

- `Application/DependencyInjection.cs` — Application services.
- `Infrastructure/DependencyInjection.cs` — Infrastructure and persistence services.
- `Auth/DependencyInjection.cs` — Authentication services.
- Api and Worker — host-specific service registration and application composition.

`Program.cs` is the composition root. It may contain service registrations and middleware pipeline configuration directly.

Move related configuration into extension methods when this improves readability, organization, or reuse. Do not extract every registration or pipeline statement into an extension method merely to minimize `Program.cs`.

Keep host-specific HTTP configuration out of Infrastructure and Auth.

## Tests and Architecture

Keep tests under `backend/tests/`, grouped by the project or boundary they verify.

Use architecture tests to enforce actual project dependency rules, including:
- Domain independence.
- Application and Infrastructure dependency directions.
- API and host boundaries.
- Auth independence from specific host applications.
- Absence of circular project dependencies.

Use ArchUnitNET for architecture rules where appropriate. Do not introduce arbitrary architecture restrictions that are not part of the agreed design.

Create test projects when there is meaningful functionality to test. Do not create empty test projects just to reproduce the directory tree.
