import json
import collections


def replacenumbers(myString):
    myString = myString.replace('0', 'zero')
    myString = myString.replace('1', 'one')
    myString = myString.replace('2', 'two')
    myString = myString.replace('3', 'three')
    myString = myString.replace('4', 'four')
    myString = myString.replace('5', 'five')
    myString = myString.replace('6', 'six')
    myString = myString.replace('7', 'seven')
    myString = myString.replace('8', 'eight')
    myString = myString.replace('9', 'nine')
    return myString

with open('emoji_strategy.json') as data_file:
    data = json.load(data_file)
    data = collections.OrderedDict(sorted(data.items()))

    for entry in data:
        try:
            print("\emojione_define:nnnn{" +
                  chr(int('0x' + data[entry]['unicode'].split("-")[-1], 16)) + "}{" +
                  replacenumbers(entry).replace('_', '') + "}{" +
                  str(int('0x' + data[entry]['unicode'].split("-")[-1], 16)) + "}{" +
                  data[entry]['unicode'] + "}")
        except:
            print("ERROR")
