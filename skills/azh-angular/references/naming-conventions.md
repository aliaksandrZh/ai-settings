# Angular Naming Conventions (Suffix-Based)

This project uses the **classic role-suffix** naming style. Class names and file
names MUST carry the role suffix. This is the default — do not apply the modern
"Intent over Role" suffixless style.

## File Names
- Use **kebab-case** for all file names.
- MUST include the role suffix as a dot-separated segment before `.ts`.
- Test files use the same base name plus `.spec.ts`.
- Split template/style files match the base name exactly.

| Type | File name | Class |
|---|---|---|
| Component | `product-list.component.ts` | `ProductListComponent` |
| Service | `auth.service.ts` | `AuthService` |
| Directive | `highlight.directive.ts` | `HighlightDirective` |
| Pipe | `format-date.pipe.ts` | `FormatDatePipe` |
| Guard | `auth.guard.ts` | `AuthGuard` (or functional: `authGuard`) |
| Interceptor | `auth.interceptor.ts` | `AuthInterceptor` (or functional: `authInterceptor`) |
| Resolver | `user.resolver.ts` | `UserResolver` (or functional: `userResolver`) |
| Interface | `user.model.ts` | `IUser` |
| Type alias | `user-status.type.ts` | `IUserStatus` |
| Enum | `user-status.enum.ts` | `UserStatus` |
| Class (data) | `order-request.class.ts` | `OrderRequest` |
| Constant token | `app-constants.token.ts` | `APP_CONSTANTS` |
| Utility | `string-utils.util.ts` | `StringUtils` |

## Class Names
- Use **PascalCase**.
- MUST end with the role suffix: `…Component`, `…Service`, `…Directive`, `…Pipe`, `…Guard`, `…Interceptor`, `…Resolver`.
- Interfaces and type aliases MUST use the **`I` prefix** (`IUser`, `IUserStatus`, `IOrderRequest`). This applies to both `interface` declarations and `type` aliases. The `.model.ts` / `.type.ts` file suffix declares the contract; the `I` prefix declares the kind.
- Plain data model classes (not interfaces) do NOT take a suffix (`User`); only interfaces and type aliases take the `I` prefix.
- Functional guards/interceptors/resolvers: export a named function (`authGuard`, `authInterceptor`, `userResolver`) and keep the `.guard.ts` / `.interceptor.ts` / `.resolver.ts` file suffix.

## Component Selectors
- MUST use the project prefix (`app-` by default, or the configured `prefix` in `angular.json`) plus kebab-case feature name.
- Example: `app-product-list`.
- Do NOT include `component` in the selector — selectors describe UI, not class role.

## File / Class Matching
- The class identifier MUST match the file's base name (minus the role suffix).
  - `auth.service.ts` → `AuthService`
  - `product-list.component.ts` → `ProductListComponent`
- Test files MUST sit next to the file they cover and share the base name:
  - `product-list.component.ts` ↔ `product-list.component.spec.ts`

## Folder Location (Feature-Based)
- Role suffixes stay in the name regardless of folder — do NOT drop `…Component` / `…Service` just because a file lives in `features/`, `core/`, or `shared/`.
- The folder conveys domain context; the suffix conveys technical role. Both are kept.
  - `features/profile/components/profile-header.component.ts` → `ProfileHeaderComponent`
  - `core/services/auth.service.ts` → `AuthService`
  - `shared/pipes/format-date.pipe.ts` → `FormatDatePipe`

## Consistency
- Do NOT mix suffix-based and suffixless files inside the same feature folder.
- Do NOT drop suffixes to "modernize" existing files unless explicitly migrating the whole module and the user approved it.
- When generating code with the Angular CLI, keep CLI defaults that emit suffixes; configure `angular.json` schematics to enforce suffixes if defaults ever change.