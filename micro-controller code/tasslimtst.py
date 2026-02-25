from firebase import  firebase
import RPi.GPIO as GPIO
import wiringpi
from time import sleep
firebase=firebase.FirebaseApplication('https://taim-test-d56d3-default-rtdb.europe-west1.firebasedatabase.app/',None)
res=firebase.get('lockers/resrv1','serrure1')
wiringpi.wiringPiSetup()
GPIO.setwarnings(False)
GPIO.setmode(GPIO.BOARD)
GPIO.setup(7,GPIO.OUT)
while (True):
    #res=firebase.get('lockers/resrv1','serrure1')
    res=firebase.get('lockers/resrv1','')
    for re in res:
        ress=firebase.get('lockers/resrv1',re)
        if ress['ouvrir'] == "oui":
            GPIO.output(ress['gpio'], 1)
            sleep(1)
            GPIO.output(ress['gpio'], 0)
            print(ress['gpio'])
    #if(res['ouvrir']== "oui"):
        #print("yes")
        #GPIO.output(7, 1)
        #sleep(1)
        #GPIO.output(7, 0)

    #else:
        #print("no")

# # 
# # while True:
# #     wiringpi.digitalWrite(7, 1)
# #     sleep(1)
# #     wiringpi.digitalWrite(7, 0)

# # GPIO.setwarnings(False)
# # GPIO.setmode(GPIO.BCM)
# # GPIO.setup(4,GPIO.IN)
# # 
# # while (True):
# #     value = GPIO.input(4)
# #     if value == True:
# #         while value ==True:
# #             print('is open')
# #             value = GPIO.input(4)
# #             sleep(1)
# #             
# #     print('is closed')
# #     sleep(1)
    
# #     if value == False:
# #         print("has taped")
# #         while value == False:
# #             value = GPIO.input(4)
# #     GPIO.output(7,1)
# #     print("1")
# #     sleep(1)
# #     GPIO.output(7,0)
# #     print("0")
# #     sleep(1)


