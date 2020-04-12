#!/usr/bin/env python3
import sys, os
from slugify import slugify

def main():
    if len(sys.argv) == 1:
        print("Usage: rename_dir directory")
        exit(0)
    dir = str(sys.argv[1])
    if not os.path.isdir(dir):
        print("Directory not found")
        exit(0)
    patterns = [
        ['운경고택', 'wkgt'],
        ['저해상', 'low']
    ]
    workDIr = os.path.abspath(dir)
    for dirpath, dirnames, filenames in os.walk(workDIr):
        print(dirpath)
        for dirname in dirnames:
            print("\t" + dirname)
        for filename in filenames:
            print("\t" + filename)
            txt, ext = os.path.splitext(filename)
            r = slugify(txt, replacements=patterns)
            print("\t" + r + ext.lower())
            os.rename(dirpath + '/' + filename, dirpath + '/' + r + ext.lower())

if __name__ == "__main__":
    main()

