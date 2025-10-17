# Tasks: Forest-Style Pomodoro App

**Input**: Design documents from `/specs/001-forest-focus-app/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), data-model.md

## Phase 1: Setup

**Purpose**: Project initialization and basic structure

- [X] T001 Create Xcode project for ForestFocus
- [X] T002 [P] Create file structure as per plan.md
- [X] T003 [P] Configure SwiftData in the project

---

## Phase 2: Foundational

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

- [X] T004 Implement Session and Tree data models in ForestFocus/DataModels/
- [X] T005 [P] Create TimerService using Combine in ForestFocus/Application/
- [X] T006 [P] Configure local notifications using UNUserNotificationCenter in ForestFocus/Application/

---

## Phase 3: User Story 1 - Start and Complete a Focus Session

**Goal**: A user can start a 25-minute focus session, see a tree grow, and have it saved to their forest upon completion.

**Independent Test**: Start a session, wait 25 minutes, and verify the tree appears in the forest view.

### Tests for User Story 1

- [X] T007 [P] [US1] Unit test for TimerService in ForestFocusTests/Unit/
- [X] T008 [P] [US1] UI test for starting and completing a session in ForestFocusTests/UI/

### Implementation for User Story 1

- [X] T009 [P] [US1] Create TimerView in ForestFocus/Views/
- [X] T010 [P] [US1] Create TimerViewModel in ForestFocus/ViewModels/
- [X] T011 [US1] Implement tree growth animation in TimerView
- [X] T012 [US1] Implement logic for starting and completing a session in TimerViewModel

---

## Phase 4: User Story 2 - Abandon a Focus Session

**Goal**: A user can cancel a session, and the tree will be marked as withered.

**Independent Test**: Start a session, cancel it, and verify the tree is not added to the forest.

### Tests for User Story 2

- [X] T013 [P] [US2] Unit test for session abandonment logic in ForestFocusTests/Unit/
- [X] T014 [P] [US2] UI test for canceling a session in ForestFocusTests/UI/

### Implementation for User Story 2

- [X] T015 [US2] Implement logic for canceling a session in TimerViewModel
- [X] T016 [US2] Handle app termination during a session in ForestFocus/Application/AppDelegate.swift

---

## Phase 5: User Story 3 - View Forest and Statistics

**Goal**: A user can view their forest of grown trees and their focus statistics.

**Independent Test**: Complete a session, navigate to the forest view, and verify the tree and stats are displayed correctly.

### Tests for User Story 3

- [X] T017 [P] [US3] Unit test for statistics calculation in ForestFocusTests/Unit/
- [X] T018 [P] [US3] UI test for forest and statistics views in ForestFocusTests/UI/

### Implementation for User Story 3

- [X] T019 [P] [US3] Create ForestView in ForestFocus/Views/
- [X] T020 [P] [US3] Create StatsView in ForestFocus/Views/
- [X] T021 [P] [US3] Create ForestViewModel in ForestFocus/ViewModels/
- [X] T022 [P] [US3] Create StatsViewModel in ForestFocus/ViewModels/
- [X] T023 [US3] Implement logic to fetch and display forest and stats data in the corresponding ViewModels

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [X] T024 [P] Implement VoiceOver and Dynamic Type support
- [X] T025 [P] Refine animations and UI for a polished look and feel
- [X] T026 Code cleanup and refactoring

---

## Dependencies & Execution Order

- **Setup (Phase 1)**: Must be completed first.
- **Foundational (Phase 2)**: Depends on Setup. Blocks all user stories.
- **User Stories (Phase 3-5)**: Depend on Foundational. Can be implemented in parallel after Foundational is complete.
- **Polish (Phase 6)**: Depends on all user stories being complete.

## Implementation Strategy

### MVP First (User Story 1 Only)

1.  Complete Phase 1: Setup
2.  Complete Phase 2: Foundational
3.  Complete Phase 3: User Story 1
4.  **STOP and VALIDATE**: Test User Story 1 independently.

### Incremental Delivery

1.  Complete Setup + Foundational.
2.  Add User Story 1 -> Test -> Deploy/Demo (MVP).
3.  Add User Story 2 -> Test -> Deploy/Demo.
4.  Add User Story 3 -> Test -> Deploy/Demo.
