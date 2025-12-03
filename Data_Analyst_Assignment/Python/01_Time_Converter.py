def minutes_to_readable(total_minutes: int) -> str:
    hours = total_minutes // 60
    minutes = total_minutes % 60
    return f"{hours} hrs {minutes} minutes"

print(minutes_to_readable(130))
print(minutes_to_readable(110))
