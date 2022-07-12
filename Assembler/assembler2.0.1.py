
#############IMPORTS################################################
from tkinter import *  # you can't use unicode or the compiler will crash
# rule of thumb:only use the chars on you're keyboard
from tkinter import scrolledtext
# negative if you want a tkinter crash-course ask me :)
from tkinter import filedialog
from tkinter import messagebox  # "basicly adware"-nate lol i joke lol jkjk
import sys  # to use exit()
import json
#from github import Github
#####################################################################

# Globals
asm_cmds = json.load(open("./asm-cmds.json"))
registers = json.load(open("./registers.json"))

# CONSTANTS
SEP = ','

print(asm_cmds)
print(registers)
# Functions


def open_file():  # opens file that you provide
    file = filedialog.askopenfile(mode="r")
    if file != None:  # checks if there is a file at that position
        text.delete("1.0", END)
        text.insert("1.0", file.read())
        file.close()


def save_file():  # saves file from you're text editor section of the app
    file = filedialog.asksaveasfile(mode="w")
    if file != None:  # checks if you named the file/selected a location
        file.write(text.get("1.0", END))
        file.close()


def about_dialog():  # about just like these words
    messagebox.showinfo("about", "compiler v1.0\n for redstone computer")


def exit_app():  # dead simple nothing special just plain ol exit
    sys.exit(0)


def send_json():
    print("sending")
    jsonfile = filedialog.askopenfile(mode="r")
    username = input("github username:")
    password = input("github password:")
    # authenticate to github
    g = Github(username, password)
    # get the authenticated user
    user = g.get_user()
    # searching for my repository
    repo = g.search_repositories("software")[0]

    # create a file and commit n push
    repo.create_file(input("name of program:"), input(
        "commit message"), json.load(jsonfile))


def exportjson():
    print("exporting")
    file = open("./export.txt", "r")
    jsonfile = open("./export.json", "a")
    for textdata in file:
        jsonfile.write(json.dumps(
            {"meta": "orisa-program", "content": textdata}))
    jsonfile.close()


def compile_code():
    try:
        inputfile = filedialog.askopenfile(mode="r")
        print("starting")
        for text_line in inputfile:
            print("current line:", text_line, end="")
            output = []
            binary = []
            output = text_line.split(SEP)
            print(binary)
            binary = decode(output)
            print(binary)
        inputfile.close()
    except OSError as err:
        print(err)


def decode(inputfile):
    try:
        # replace "owner with you're username
        exportfile = open("./export.txt", "a")
        exportfile.write("\n")
        dest = ""  # define default vars
        srca = ""  # ^
        srcb = ""  # ^
        opcode = ""  # ^
        opcode = inputfile[0]
        dest = inputfile[1]
        srca = inputfile[2]
        srcb = inputfile[3]
        print("decode")

        if srca in registers.values():
            srca = registers[srca]

        if srcb in registers.values():
            srcb = registers[srcb]

        if dest in registers.values():
            dest = registers[dest]

        print("binary arguments:", opcode, ":", dest, srca, srcb)
        byte_code = asm_cmds[opcode]

        exportfile.write(f"{byte_code}{dest}{srca}{srcb}\n")
        exportfile.close()

    except OSError as err:
        print(err)


####################################################################
root_win = Tk()  # the window plane
root_win.title("redstonecompilerv1.0")  # title of this app
root_win.geometry("640x480")  # default size
main_menu = Menu(root_win)  # file menu root
root_win.config(menu=main_menu)  # config go brrrr
file_menu = Menu(main_menu)  # draws the file menu
main_menu.add_cascade(label="File", menu=file_menu)  # adds the cascade
file_menu.add_command(label="Open", command=open_file)  # calls open_file()
file_menu.add_command(label="Save", command=save_file)  # calls save_file()
# shows about dialog
file_menu.add_command(label="About", command=about_dialog)
# yes it exits you're life ...for now...
file_menu.add_command(label="Exit", command=exit_app)
file_menu.add_command(label="export json", command=exportjson)  # exports json
file_menu.add_command(label="send json to program libary", command=send_json)
# turns asm to binary
main_menu.add_command(label="Compile", command=compile_code)
text = scrolledtext.ScrolledText(
    root_win, width=80, height=30)  # text editor part
text.pack(fill="both", expand="yes")  # renders the text editor
root_win.mainloop()  # loops the app so it can call events
# Good job you found me now leave NOW!!! ⓿_⓿ I don't want visitors
# I am garry the Computer bug, now you are bugging me. leave or i will
# live in you're programs I like to live in C because it is harder to
# debug and kill me. ~nates pet bug
