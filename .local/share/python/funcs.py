def split_into_lines(tar, delimitator):
    if delimitator:
        print(tar.replace(delimitator, "\n"))
    else:
        print('\n'.join(c for c in tar))
