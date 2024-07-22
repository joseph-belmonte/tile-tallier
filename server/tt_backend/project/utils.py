from datetime import timedelta


def str_to_timedelta(time_str):
    if time_str.endswith("m"):
        minutes = int(time_str[:-1])
        return timedelta(minutes=minutes)
    elif time_str.endswith("d"):
        days = int(time_str[:-1])
        return timedelta(days=days)
    else:
        raise ValueError(f"Invalid time format: {time_str}")
