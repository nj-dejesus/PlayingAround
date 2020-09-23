"""
	Saying Hello
		The "Hello World" program is the first program you learn to write in many languages,
		but it doesn't invovle any input.

		So create a program that prompts for your name and prints a greeting using your name.

		Example Output:
			What is your name? Brian
			Hello, Brian, nice to meet you!

		Constraint
			Keep the input, string concatenation, and output separate.
"""
#!/usr/bin/env python3
import subprocess

#clear the screen
subprocess.call('clear', shell=True)

#Ask for user input
name = input("What is your name? ")
print ("Hello, " + name +", nice to meet you!")

