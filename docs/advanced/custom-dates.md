# Custom Date Ranges

Advanced usage of custom date ranges for flexible reporting.

## Basic Usage

Custom date ranges allow you to generate reports for any specific time period:

```bash
git-reporter generate \
  --period custom \
  --start 2024-01-01 \
  --end 2024-12-31
```

## Date Format

All dates must use ISO 8601 format: `YYYY-MM-DD`

- ✅ Valid: `2024-12-14`, `2024-01-01`, `2024-06-30`
- ❌ Invalid: `12/14/2024`, `14-12-2024`, `Dec 14, 2024`

## Common Patterns

See [Report Periods](../user-guide/report-periods.md) for more examples and details on using custom date ranges effectively.

## Dynamic Dates

Use shell commands to generate dynamic dates:

```bash
# Last 30 days
git-reporter generate \
  --period custom \
  --start $(date -d "30 days ago" +%Y-%m-%d) \
  --end $(date +%Y-%m-%d)

# Last month
git-reporter generate \
  --period custom \
  --start $(date -d "last month" +%Y-%m-01) \
  --end $(date -d "last month" +%Y-%m-31)

# Previous quarter
git-reporter generate \
  --period custom \
  --start $(date -d "3 months ago" +%Y-%m-01) \
  --end $(date -d "1 month ago" +%Y-%m-31)
```

## See Also

- [Report Periods](../user-guide/report-periods.md) - All time period options
- [CLI Commands](../user-guide/cli-commands.md) - Command reference
