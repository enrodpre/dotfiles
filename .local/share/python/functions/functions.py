#!/bin/python
import os


def get_filename(fullpath: str) -> str:
    try:
        filename, filext = os.path.basename(fullpath).split('.')
    except ValueError:
        filename = os.path.basename(fullpath)

    return filename
