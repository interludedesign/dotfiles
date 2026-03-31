---
name: author-acceptance-criteria
description: This skill should be used when creating acceptance criteria for features, bugs, or user stories. Use when the user asks to write AC, create acceptance criteria, or needs help defining scenarios in Given/When/Then format.
---

# Acceptance Criteria Writer

Create clear, testable acceptance criteria using Given/When/Then format.

## When to Use
- User says "write acceptance criteria", "create AC", "ac", "a/c", or similar
- Needs scenarios for features, bugs, or user stories
- Wants to document expected behavior

## Workflow

1. **Ask approach**: "Would you like me to analyze the code/bug to generate scenarios, or format criteria you have in mind?"

2. **Generate from analysis** (if chosen):
   - Identify state variations, input cases, boundary conditions, errors, permissions
   - Create scenarios for main flows and key edge cases

3. **Format existing criteria** (if chosen):
   - Ask clarifying questions about each scenario
   - Structure ideas into Given/When/Then format

## Standard Format

```markdown
#### Scenario N: [Brief Descriptive Name]

**Given**
- [Context/precondition]

**When**
- [Action or event]

**Then**
- [Expected outcome 1]
- [Expected outcome 2]

---

#### Technical Requirements
- [Performance/security/compatibility requirements]
```

## Rules
- **Separate sections**: Given, When, Then are distinct with bullets
- **Observable outcomes**: Focus on user-visible behavior, not implementation
- **Specific**: Use concrete values and measurable results
- **Concise**: Keep bullets brief and clear

## Examples

✅ **Good**:
```markdown
#### Scenario 1: Valid Login

**Given**
- User is on login page

**When**
- User enters valid credentials and clicks "Sign In"

**Then**
- User is redirected to dashboard
- Welcome message displays
- Session is created
```

❌ **Bad**:
```markdown
#### Scenario 1: Login

**Given**
- User is on page

**When**
- User does stuff

**Then**
- It should work correctly
- Database updates
- API calls service layer
```

## Coverage Checklist
- Main happy path
- Invalid input handling
- Edge cases (empty, null, max values)
- Error conditions
- Different user roles (if applicable)


Always place the happy path first
