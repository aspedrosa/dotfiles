#!/usr/bin/python3

import argparse
import os
import sys

def create_package_info_and_recurse(path, package_name):
    package_info_path = os.path.join(path, "package-info.java")

    with open(package_info_path, "w+") as package_info_file:
        package_info_file.write(
           "/**\n" + \
           " * \n" + \
           " */\n" + \
           "package " + package_name + ";\n"
        )

    for child_package in os.listdir(path):
        child_package_path = os.path.join(path, child_package)
        if os.path.isdir(child_package_path):
            create_package_info_and_recurse(child_package_path, package_name + "." + child_package)

def main(args):
    root_directory = args.root_directory

    if not os.path.exists(root_directory):
        print("Path " + root_directory + " not found", file=sys.stderr)
        sys.exit(1)
    elif not os.path.isdir(root_directory):
        print("Path " + root_directory + " is not a directory", file=sys.stderr)
        sys.exit(2)

    root_path = os.path.abspath(root_directory)

    create_package_info_and_recurse(root_path, os.path.basename(root_path))

if __name__ == "__main__":
    args_parser = argparse.ArgumentParser()

    args_parser.add_argument("root_directory")

    args = args_parser.parse_args()

    main(args)
