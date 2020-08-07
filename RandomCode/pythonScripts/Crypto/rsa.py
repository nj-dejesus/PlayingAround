#!/usr/bin/python3
import subprocess
import sys
import rsa
import base64
import math

#Clears the screen
subprocess.call('clear', shell=True)

print("RSA Encryptor/Decryptor")
print("*" *60)

def isPrime(n):
	if(n<1):
		return False
	elif(n<=3 and n>=1):
		return True
	elif(n % 2 == 0 or n %3 ==0):
		return False
	else:
		return True

def encryptionFunc():
	test = True:
	while :
		num1=input("Choose first prime number: ")
		isPrime(num1)
	while True:
		num2=input("Choose second prime number: ")
		isPrime(num2)

#def decryptionFunc():

print ("Make a Choice: ")
print ("1: Encryption")
print ("2: Decryption")

choice = input("Choice Selected: ")

try:
	if choice == '1':
		print ("You Chose Encryption")
		print ("*" * 60)
		encryptionFunc()
	elif choice == '2':
		print ("You Chose Decryption")
		print ("*" * 60)
	else:
		print ("Invalid Choice")
		sys.exit()
except KeyboardInterrupt:
	print ("You pressed Ctrl+C")
	sys.exit(0)

