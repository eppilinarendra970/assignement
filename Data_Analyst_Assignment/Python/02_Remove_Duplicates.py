def remove_duplicates(s: str) -> str:
    result = ""
    for ch in s:
        if ch not in result:
            result += ch
    return result

print(remove_duplicates("banana"))
print(remove_duplicates("aabbcc"))
