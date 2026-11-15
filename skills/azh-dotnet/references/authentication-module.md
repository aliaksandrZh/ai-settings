# Authentication Module

`Azh.Auth` is an independent reusable class library containing authentication functionality. It can be referenced by Api, Worker, and other host applications.

The module owns authentication concerns such as:
- ASP.NET Core Identity integration.
- User account and credential management.
- Access and refresh token generation and validation.
- Refresh token lifecycle, rotation, and persistence.
- Authentication-specific services and contracts.
- Authentication service registration through `AddAuth()`.

Organize the module internally according to its actual responsibilities. Use the directories in the project tree when relevant; do not create unused directories.

## Host Responsibilities

**Api:**
- Authentication HTTP endpoints.
- HTTP request and response DTOs.
- JWT Bearer registration and token validation configuration.
- Refresh token cookie handling, including HttpOnly, Secure, and SameSite settings.
- HTTP-specific claims extraction and current-user access.
- CORS and HTTP authorization configuration.

**Worker:**
- May reference Auth when authentication services are required.
- Must not duplicate authentication or token-generation implementations.
- Must not introduce HTTP dependencies for background processing.

Keep host-specific functionality in the host project. Auth must not depend on `HttpContext`, HTTP middleware, API cookies, CORS, or a specific host.

Do not force Auth to reference the main Application or Infrastructure projects. Add dependencies only when a concrete integration requirement justifies them.
