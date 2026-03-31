---
name: create-postgres-fixture-data
description: Generate SQL seed/fixture scripts for manual testing. Guides you through gathering requirements, reading the schema, and writing a well-structured SQL file to seed the database into a specific scenario.
---

# Create PostgreSQL Fixture Data

## Overview

This skill provides a structured workflow for generating SQL seed/fixture scripts for manual testing. General guidance:

1. Write the fixtures in SQL to a `.sql` file
2. Name the file after the scenario being tested, unless the user explicitly asks for a combined file such as `fixtures.sql`
3. Place in the same directory as the spec or acceptance criteria file being worked from
4. Always truncate the database before running a script

## Workflow

### Step 1: Gather Requirements

You should be working from a set of acceptance criteria. If the user hasn't provided them, ask.

The user wants records creating so they can start the application locally and use the feature to verify it is working.

Acceptance criteria will typically be in a 'given, when, then' format. Most likely the user wants to set up the application in the 'given' state so they can trigger the 'when' scenario themselves and observe the 'then' result.

Prefer working on one acceptance criterion at a time and naming the SQL file after it.

If the user explicitly wants all scenarios in one file, create a combined `fixtures.sql` and group the inserts and comments by acceptance criterion within that file.

### Step 2: Read the Database Schema

Export the schema so you understand the tables, columns, constraints, and enums before writing any SQL.

### Step 2.5: Identify the Authenticated User

There is almost always a pre-defined authenticated user configured in the global instructions (e.g. a specific email, user ID, or subject identifier). Use that user as the authenticated identity or record owner in your fixtures rather than creating a new one.

### Step 3: Determine What Records Need Creating

Determine which records need creating to set up the 'given' scenario.

When a scenario is a negative case that depends on the absence of data (e.g. "record does not exist") or on request headers only (e.g. unauthenticated requests), document that clearly in comments instead of inventing unnecessary seed rows.

### Step 4: Write the Script

#### Script Structure

```sql
-- Fixture: [Brief description]
-- Purpose: [What scenario/acceptance criteria this tests]
-- Scenario: [Initial state description]
-- Expected: [Expected state after test]

BEGIN;

-- 1. Create dependencies in order (parent records first)
-- 2. Create main entities
-- 3. Create child records
-- 4. Add review queries to verify inserted data

COMMIT;
```

#### PostgreSQL Syntax Notes

**Date ranges:**
```sql
-- CORRECT: Cast intervals to date type
daterange(CURRENT_DATE, (CURRENT_DATE + INTERVAL '1 year')::date, '[)')

-- WRONG: INTERVAL returns timestamp, daterange expects date
daterange(CURRENT_DATE, CURRENT_DATE + INTERVAL '1 year', '[)')
```

**Common date patterns:**
```sql
CURRENT_DATE                                           -- Today
(CURRENT_DATE + INTERVAL '1 year')::date              -- One year from today
(CURRENT_DATE - INTERVAL '30 days')::date             -- 30 days ago
CURRENT_TIMESTAMP                                      -- Current timestamp with timezone
```

**JSONB defaults:**
```sql
'{}'::jsonb  -- Empty JSON object
```

**UUIDs:**
```sql
gen_random_uuid()  -- Auto-generate UUID
```

**Key field notes:**
- **Enum values:** Check the schema's CHECK constraints for valid values
- **Soft deletes:** Use `deleted_at IS NULL` for active records, `CURRENT_TIMESTAMP` for deleted
- **Foreign keys:** Verify parent records exist before inserting children
- **Required fields:** Check NOT NULL constraints in schema
- **ID values:** Use explicit IDs in a high test range (e.g. 9000+) to avoid conflicts with existing data

### Step 5: Provide a Summary

After generating the SQL script, provide a concise summary of what was created.

Always include a Markdown table that maps every important identifier created or referenced by the fixture to the acceptance criterion it supports.

```
I've created the SQL script to include:

- [Count] [entity description] (IDs: X, Y, Z) — [Purpose/expected behaviour]

| Identifier | Value | Acceptance Criteria | Notes |
| --- | --- | --- | --- |
| [field name] | [value] | AC1 | [notes] |
| [field name] | [value] | AC2 | Not inserted; use for 404 |

The script covers:
- ✅ AC1: [Brief description]
- ✅ AC2: [Brief description]
```
