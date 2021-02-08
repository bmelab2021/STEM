#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Aug 28 20:56:22 2018

@author: bme
"""


import scipy.io as sio
import scipy.io as sio
import numpy as np
import os


from keras.models import Sequential
from keras.layers import Dense, Dropout
from keras.layers import Embedding
from keras.layers import LSTM
os.environ["CUDA_VISIBLE_DEVICES"]="0,1"
from keras.models import load_model

### lstm
model = Sequential()
model.add(Embedding(600, output_dim=256))
model.add(LSTM(128))
model.add(Dropout(0.5))
model.add(Dense(1, activation='sigmoid'))

model.compile(loss='binary_crossentropy',
              optimizer='rmsprop',
              metrics=['accuracy'])



model = load_model('base_model.h5')

### load data
pnf20150=(sio.loadmat('./pnf20150.mat'))['pnf20150']
pnf20151=(sio.loadmat('./pnf20151.mat'))['pnf20151']
pnf20160=(sio.loadmat('./pnf20160.mat'))['pnf20160']
pnf20161=(sio.loadmat('./pnf20161.mat'))['pnf20161']
pnf20170=(sio.loadmat('./pnf20170.mat'))['pnf20170']
pnf20171=(sio.loadmat('./pnf20171.mat'))['pnf20171']


pnf0=np.vstack((pnf20150,pnf20160,pnf20170))
pnf1=np.vstack((pnf20151,pnf20161,pnf20171))
print(pnf0.shape)
print(pnf1.shape)

val0=pnf0[0:821]
val1=pnf1[0:1265]
train0=pnf0[821:4106]
train1=pnf1[1265:6326]

y_val0=np.zeros((821,1))
y_val1=np.ones((1265,1))
y_train0=np.zeros((3285,1))
y_train1=np.ones((5061,1))

x_train=np.vstack((train0,train1))
y_train=np.vstack((y_train0,y_train1))

x_val=np.vstack((val0,val1))
y_val=np.vstack((y_val0,y_val1))


list1=[];
list2=[];
list3=[];
y32=[];
y33=[];
y44=[];


### weight for train
cw = {0: 1.53, 1: 1} 
best=0;
for i in range(1,500): 
    model.fit(x_train, y_train, batch_size=256, epochs=1,class_weight=cw)
    score = model.evaluate(x_val, y_val, batch_size=256)
    y3 = model.predict_classes(x_val)
    y4 = model.predict(x_val)
    m=i

    print('dangqian acc',score[1])
    a=score[1]
    if best<a:
        best=a
        model.save('model_eight'+str(m)+'.h5')
        y32.append(y_val)
        y33.append(y3)
        y44.append(y4)
        list2.append(score[1])
        list1.append(score[0])
        list3.append(i)
    print(best)

####计算敏感性与特异性
aa=y3
numz=len(list(aa))
a0=aa[0:821]
a1=aa[821:2086]
numz0=list(a0).count(0)
numz1=list(a1).count(1)
num0=len(list(a0))
num1=len(list(a1))
print('特异性的值是',numz0/num0)
print('敏感性的值是',numz1/num1)
