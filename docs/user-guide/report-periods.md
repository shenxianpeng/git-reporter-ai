# Report Periods

Understanding and using different time periods for your reports.

## Available Periods

git-reporter supports six report periods:

| Period | Description | Start Point | Typical Use Case |
|--------|-------------|-------------|------------------|
| `daily` | Today's commits | Start of today (00:00) | Daily standups, quick updates |
| `weekly` | Current week | Monday of current week | Weekly team meetings, manager reports |
| `monthly` | Current month | First day of month | Monthly reviews, performance reports |
| `quarterly` | Current quarter | First day of quarter | Quarterly business reviews |
| `yearly` | Current year | January 1st | Annual reviews, year-end summaries |
| `custom` | User-defined range | Custom start date | Specific projects, audits, custom needs |

## Period Details

### Daily

Reports on commits from today.

```bash
git-reporter generate --period daily
```

**Time Range**: Today 00:00:00 to now

**Use Cases**:
- Daily standup preparation
- End-of-day summaries
- Quick status updates

### Weekly

Reports on commits from Monday of the current week.

```bash
git-reporter generate --period weekly
```

**Time Range**: Monday 00:00:00 to now

**Use Cases**:
- Weekly team meetings
- Manager status reports
- Sprint summaries (for week-long sprints)

!!! tip "Default Period"
    Weekly is the default period if not specified.

### Monthly

Reports on commits from the first day of the current month.

```bash
git-reporter generate --period monthly
```

**Time Range**: First day of month 00:00:00 to now

**Use Cases**:
- Monthly performance reviews
- Client reports
- Team productivity summaries

### Quarterly

Reports on commits from the first day of the current quarter.

```bash
git-reporter generate --period quarterly
```

**Quarters**:
- Q1: January - March
- Q2: April - June
- Q3: July - September
- Q4: October - December

**Use Cases**:
- Quarterly business reviews (QBRs)
- Performance evaluations
- Strategic planning updates

### Yearly

Reports on commits from January 1st of the current year.

```bash
git-reporter generate --period yearly
```

**Time Range**: January 1st 00:00:00 to now

**Use Cases**:
- Annual performance reviews
- Year-end summaries
- Career development discussions

### Custom

Reports on commits within a user-specified date range.

```bash
git-reporter generate \
  --period custom \
  --start 2024-01-01 \
  --end 2024-12-31
```

**Time Range**: User-defined start to end date

**Use Cases**:
- Specific project timeframes
- Audit periods
- Custom reporting needs
- Historical analysis

## Usage Examples

### Basic Usage

```bash
# Weekly report (default)
git-reporter generate

# Explicit weekly report
git-reporter generate --period weekly

# Monthly report
git-reporter generate --period monthly
```

### Custom Date Ranges

```bash
# Full year 2024
git-reporter generate \
  --period custom \
  --start 2024-01-01 \
  --end 2024-12-31

# Q4 2024
git-reporter generate \
  --period custom \
  --start 2024-10-01 \
  --end 2024-12-31

# Specific month
git-reporter generate \
  --period custom \
  --start 2024-11-01 \
  --end 2024-11-30

# Sprint period (2 weeks)
git-reporter generate \
  --period custom \
  --start 2024-12-01 \
  --end 2024-12-14

# Last 30 days
git-reporter generate \
  --period custom \
  --start $(date -d "30 days ago" +%Y-%m-%d) \
  --end $(date +%Y-%m-%d)
```

### Saving Reports by Period

```bash
# Daily report with date stamp
git-reporter generate --period daily \
  --output daily-$(date +%Y-%m-%d).md

# Weekly report
git-reporter generate --period weekly \
  --output weekly-$(date +%Y-W%V).md

# Monthly report
git-reporter generate --period monthly \
  --output monthly-$(date +%Y-%m).md

# Quarterly report
git-reporter generate --period quarterly \
  --output Q$(date +%q)-$(date +%Y).md

# Yearly report
git-reporter generate --period yearly \
  --output yearly-$(date +%Y).md
```

## Period Selection Guide

### Choose Daily When:

- ✅ You need quick daily updates
- ✅ Running daily standups
- ✅ Tracking day-to-day progress
- ❌ Not ideal for comprehensive summaries

### Choose Weekly When:

- ✅ Reporting to managers regularly
- ✅ Weekly team sync meetings
- ✅ Sprint-based development (1-week sprints)
- ✅ Most common use case

### Choose Monthly When:

- ✅ Monthly performance reviews
- ✅ Client billing periods
- ✅ Longer project cycles
- ✅ More comprehensive analysis needed

### Choose Quarterly When:

- ✅ Business review meetings
- ✅ Performance evaluations
- ✅ Long-term project tracking
- ✅ Strategic planning

### Choose Yearly When:

- ✅ Annual performance reviews
- ✅ Year-end summaries
- ✅ Career development discussions
- ✅ Long-term contribution analysis

### Choose Custom When:

- ✅ Specific project deadlines
- ✅ Audit requirements
- ✅ Non-standard reporting periods
- ✅ Historical analysis
- ✅ Multiple sprints or iterations

## Date Format

Custom period dates must use ISO 8601 format: `YYYY-MM-DD`

```bash
# Valid formats
--start 2024-01-01
--start 2024-12-31
--start 2024-06-15

# Invalid formats
--start 01-01-2024  # Wrong order
--start 2024/01/01  # Wrong separator
--start Jan 1, 2024 # Text format
```

## Timezone Considerations

All dates and times use your local system timezone.

```bash
# Check your system timezone
date +%Z

# Set timezone (temporary)
TZ=America/New_York git-reporter generate
```

## Best Practices

### 1. Consistent Timing

Generate reports at consistent times:

```bash
# Weekly report every Friday at 5 PM
0 17 * * 5 git-reporter generate --period weekly --output ~/reports/weekly.md
```

### 2. Archive Reports

Keep a history of reports:

```bash
#!/bin/bash
REPORT_DIR=~/reports/$(date +%Y)
mkdir -p $REPORT_DIR
git-reporter generate --period weekly \
  --output $REPORT_DIR/week-$(date +%V).md
```

### 3. Multiple Periods

Generate reports for multiple periods:

```bash
# Generate daily, weekly, and monthly
git-reporter generate --period daily --output daily.md
git-reporter generate --period weekly --output weekly.md
git-reporter generate --period monthly --output monthly.md
```

### 4. Automate Reports

Use cron jobs or scheduled tasks:

```cron
# Daily report at 6 PM
0 18 * * * cd ~/work && git-reporter generate --period daily --output ~/reports/daily-$(date +\%Y-\%m-\%d).md

# Weekly report on Friday at 5 PM
0 17 * * 5 cd ~/work && git-reporter generate --period weekly --output ~/reports/weekly-$(date +\%Y-W\%V).md

# Monthly report on 1st at 9 AM
0 9 1 * * cd ~/work && git-reporter generate --period monthly --output ~/reports/monthly-$(date +\%Y-\%m).md
```

## Common Scenarios

### Sprint Reports

For 2-week sprints:

```bash
git-reporter generate \
  --period custom \
  --start 2024-12-01 \
  --end 2024-12-14 \
  --output sprint-24.md
```

### Project Phase Reports

Track specific project phases:

```bash
# Alpha phase
git-reporter generate \
  --period custom \
  --start 2024-01-01 \
  --end 2024-03-31 \
  --output project-alpha-phase.md

# Beta phase
git-reporter generate \
  --period custom \
  --start 2024-04-01 \
  --end 2024-06-30 \
  --output project-beta-phase.md
```

### Comparison Reports

Compare different periods:

```bash
# This month vs last month
git-reporter generate --period monthly --output current-month.md
git-reporter generate \
  --period custom \
  --start $(date -d "1 month ago" +%Y-%m-01) \
  --end $(date -d "1 month ago" +%Y-%m-31) \
  --output last-month.md
```

## See Also

- [CLI Commands](cli-commands.md) - Complete command reference
- [Usage Examples](usage-examples.md) - Real-world examples
- [Custom Date Ranges](../advanced/custom-dates.md) - Advanced date range usage
