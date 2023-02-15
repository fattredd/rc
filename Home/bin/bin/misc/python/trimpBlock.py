#!/bin/python

from decimal import Decimal
import lzstring
import win32clipboard
import json

def getClip():
  win32clipboard.OpenClipboard()
  data = win32clipboard.GetClipboardData()
  win32clipboard.CloseClipboard()
  return data

def parseSave(save):
  x = lzstring.LZString()
  try:
    jsonData = x.decompressFromBase64(save)
  except:
    return "Clipboard error"
  obj = json.loads(jsonData)
  gBase = obj['buildings']['Gym']['increase']['by']
  gLevel = obj['buildings']['Gym']['purchased']

  tBase = obj['jobs']['Trainer']['modifier']
  tLevel = obj['jobs']['Trainer']['owned']

  soldiers = obj['resources']['trimps']['maxSoldiers']
  
  if obj['equipment']['Shield']['blockNow']:
    sBase = obj['equipment']['Shield']['blockCalculated']
    sLevel = obj['equipment']['Shield']['level']
  else:
    sBase = 0
    sLevel = 0
  
  return findMax(gBase, gLevel, sBase, sLevel, tBase, tLevel, soldiers)

def findBlock(gBase, gLevel, sBase, sLevel, tBase, tLevel, soldiers):
  gTotal = gBase * gLevel
  sTotal = sBase * sLevel
  tTotal = tBase / 100 * tLevel
  return (sTotal + gTotal) * (1 + tTotal) * soldiers

def findMax(gBase, gLevel, sBase, sLevel, tBase, tLevel, soldiers):
  current = findBlock(gBase, gLevel, sBase, sLevel, tBase, tLevel, soldiers)
  gym = findBlock(gBase, gLevel+1, sBase, sLevel, tBase, tLevel, soldiers)
  sheild = findBlock(gBase, gLevel, sBase, sLevel+1, tBase, tLevel, soldiers)
  train = findBlock(gBase, gLevel, sBase, sLevel, tBase, tLevel+1, soldiers)
  res = ''
  if (gym > sheild and gym > train):
    res = "gym"
  else:
    if (sheild > train):
      res = "sheild"
    else:
      res = "train"
  return res, "gym", pSci(gym-current), "train", pSci(train-current), "sheild", pSci(sheild-current)

def pSci(val):
  n = Decimal(val)
  a = '%E' % n
  return a.split('E')[0].rstrip('0').rstrip('.') + 'E' + a.split('E')[1]

'''
# Don't change much
gB = 439
sB = 10700
tB = 45
sol = 1110

# Levels
gL = 88
sL = 2
tL = 135
'''

if __name__ == "__main__":
  while (True):
    _ = input("Enter to grab clipboard")
    save = getClip()
    print(parseSave(save))
