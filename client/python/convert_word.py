"""
Converts a text file containing words, one per line, into a Dart file containing a set of strings.
"""

# Your input text file containing words, one per line
INPUT_FILE = "word_list.txt"
# Output Dart file
OUTPUT_FILE = "word_list.dart"


def main():
    """
    Example:

    """
    # Read words from the file
    with open(INPUT_FILE, "r") as file:
        words = file.read().splitlines()

    # Prepare the Dart set string
    dart_set = "{" + ", ".join(f"'{word}'" for word in words) + "};"

    # Write the Dart set to the output file
    with open(OUTPUT_FILE, "w") as file:
        file.write("final Set<String> wordList = ")
        file.write(dart_set)


if __name__ == "__main__":
    main()
