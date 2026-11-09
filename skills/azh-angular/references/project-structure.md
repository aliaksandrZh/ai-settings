# Project Structure

The defined project structure is mandatory and must be followed exactly. Do not simplify, flatten, reorganize, or reduce nesting, even if a different structure seems more appropriate or less complex.

Files must always be created in their designated directories.

Empty directories may either:
- Be created with a `.gitkeep` file, or
- Be omitted until they are needed.

Omitting an empty directory does not allow changing the defined hierarchy once a file needs to be created.

## Folder Structure

```text
src/app/
├── core/                                     # Application-wide infrastructure
│   ├── auth/
│   │   ├── auth.guard.spec.ts
│   │   ├── auth.guard.ts
│   │   ├── auth.service.spec.ts
│   │   └── auth.service.ts
│   ├── config/
│   │   ├── app-config.service.spec.ts
│   │   ├── app-config.service.ts
│   │   └── app-config.ts
│   ├── error-handling/
│   │   ├── global-error-handler.spec.ts
│   │   └── global-error-handler.ts
│   ├── interceptors/
│   │   ├── auth.interceptor.spec.ts
│   │   ├── auth.interceptor.ts
│   │   ├── http-error.interceptor.spec.ts
│   │   └── http-error.interceptor.ts
│   └── services/                             # Application-wide infrastructure services
│
├── domain/                                   # Shared business domain
│   ├── models/                               # Business entities and value objects
│   │   └── <model>.model.ts
│   ├── repositories/                         # Shared repository contracts and implementations
│   │   └── <repository>.repository.ts
│   ├── services/                             # Domain services and business rules
│   │   └── <service>.service.ts
│   ├── enums/                                # Domain enumerations
│   │   └── <enum>.enum.ts
│   └── types/                                # Domain-specific types
│       └── <type>.type.ts
│
├── features/                                 # Route-level application areas and reusable business functionality
│   └── <feature>/
│       ├── <feature>.component.html
│       ├── <feature>.component.scss
│       ├── <feature>.component.spec.ts
│       ├── <feature>.component.ts
│       ├── <feature>.model.ts
│       ├── <feature>.service.spec.ts
│       ├── <feature>.service.ts
│       ├── <feature>.store.spec.ts
│       ├── <feature>.store.ts
│       └── components/
│           └── <component>/
│               ├── <component>.component.html
│               ├── <component>.component.scss
│               ├── <component>.component.spec.ts
│               └── <component>.component.ts
│
├── shared/                                   # Generic reusable building blocks
│   ├── directives/
│   │   ├── <directive>.directive.spec.ts
│   │   └── <directive>.directive.ts
│   ├── pipes/
│   │   ├── <pipe>.pipe.spec.ts
│   │   └── <pipe>.pipe.ts
│   ├── ui/                                   # Reusable UI components and layouts
│   │   ├── components/
│   │   │   └── <component>/
│   │   │       ├── <component>.component.html
│   │       │       ├── <component>.component.scss
│   │       │       ├── <component>.component.spec.ts
│   │       │       └── <component>.component.ts
│   │   └── layouts/
│   │       └── <layout>/
│   │           ├── <layout>.component.html
│   │           ├── <layout>.component.scss
│   │           ├── <layout>.component.spec.ts
│   │           └── <layout>.component.ts
│   └── util/                                 # Generic pure functions and helpers
│       ├── <util>.util.spec.ts
│       └── <util>.util.ts
│
└── theme/                                    # Global visual system
    ├── dark.scss
    ├── light.scss
    ├── styles.scss
    ├── theme.scss
    └── tokens.scss
```

## Architectural Boundaries

- `domain/` — Contains shared business-domain concepts, including business entities, value objects, domain models, repository contracts, domain services, business rules, enumerations, and domain-specific types. It provides a central location for business concepts used across multiple features. It MUST NOT depend on Angular, application infrastructure, presentation concerns, or feature-specific code.
- `core/` — Contains application-wide infrastructure such as authentication, configuration, global error handling, HTTP interceptors, and infrastructure services. It MUST NOT contain business entities, domain models, repository contracts, or feature-specific business logic.
- `features/` — Contains route-level application areas, feature-specific business functionality, UI composition, state management, API integration, and application workflows. Features MAY consume shared domain models, services, and repository contracts from `domain/`.
- `shared/` — Contains generic reusable building blocks, including UI components, layouts, directives, pipes, and utilities. Components in `shared/ui` MUST be presentational and MUST NOT contain business logic or feature-specific state. `shared/` MUST NOT depend on `features/` or `domain/`.
- `theme/` — Contains the global visual system, design tokens, themes, and global styles. It MUST NOT contain application or business logic.

Even if the application has only a single page, the defined `pages/` and `features/` structure MUST be followed.

## Domain and Repository Rules

1. Business entities, value objects, and business models MUST be placed in `domain/` when they represent concepts shared across the application.
2. Repository interfaces and contracts MUST be defined in `domain/repositories/` when they represent shared business-domain abstractions.
3. Repository implementations MAY be placed in `domain/` only when they contain pure domain logic and do not depend on external infrastructure.
4. Implementations that depend on HTTP APIs, databases, browser storage, or other external infrastructure MUST NOT be placed in `domain/`. Such implementations belong in the appropriate infrastructure or data-access layer.
5. Feature-specific models, view models, UI state, and API-specific DTOs MUST remain within their respective feature directories unless they are genuinely shared domain concepts.
6. Domain models MUST NOT contain HTTP request/response details, database-specific structures, or persistence implementation details.
7. Features MUST NOT import business dependencies from other features merely to reuse domain models, repository contracts, or domain services. Shared business dependencies MUST be placed in `domain/`.
8. `domain/` MUST remain independent of `core/`, `features/`, `shared/`, Angular, and application infrastructure.

## Dependency Direction

```text
pages    ──→ features
pages    ──→ domain
pages    ──→ shared
pages    ──→ core

features ──→ domain
features ──→ shared
features ──→ core

domain   ──→ no application dependencies

shared   ──→ no business dependencies

features ──→ other features (FORBIDDEN)
```

`pages/` and `features/` MAY use `domain/`, `shared/`, and `core/`. `shared/` MUST remain independent of application-specific business logic. `domain/` MUST remain independent of all application layers and infrastructure.

The domain layer is the central location for shared business concepts and contracts. Features consume these abstractions without depending on one another.