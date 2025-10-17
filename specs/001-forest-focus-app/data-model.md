# Data Model: Forest-Style Pomodoro App

This document defines the data model for the Forest-style Pomodoro application. The model is designed to be simple and efficient for local storage using SwiftData.

## Entities

### Session

Represents a single focus session.

| Attribute | Type | Description | Rules |
|---|---|---|---|
| `id` | `UUID` | Unique identifier for the session. | Primary Key |
| `startTime` | `Date` | The date and time when the session started. | Required |
| `endTime` | `Date` | The date and time when the session ended. | Required |
| `duration` | `TimeInterval` | The length of the session in seconds. | Required |
| `status` | `SessionStatus` | The outcome of the session. | Required |
| `tree` | `Tree` | The tree associated with the session. | Required, one-to-one relationship |

### Tree

Represents the visual reward for a completed session.

| Attribute | Type | Description | Rules |
|---|---|---|---|
| `id` | `UUID` | Unique identifier for the tree. | Primary Key |
| `completionDate` | `Date` | The date when the tree was fully grown. | Required |
| `session` | `Session` | The session that grew the tree. | Required, one-to-one relationship |

## Enums

### SessionStatus

Represents the status of a focus session.

| Value | Description |
|---|---|
| `completed` | The user successfully completed the focus session. |
| `abandoned` | The user cancelled or quit the session before completion. |

## Relationships

-   A `Session` has one `Tree`.
-   A `Tree` belongs to one `Session`.

This one-to-one relationship ensures that each tree is uniquely associated with a single focus session.