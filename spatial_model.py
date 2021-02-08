#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Aug  1 11:58:18 2019
@author: asus
"""


import scipy.io as sio
import numpy as np
import os

#from sklearn.neighbors import KNeighborsClassifier
#from sklearn.svm import SVC, LinearSVC, NuSVC
#from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier, AdaBoostClassifier, GradientBoostingClassifier
from sklearn.ensemble import BaggingClassifier
from sklearn.ensemble import VotingClassifier
#from sklearn.experimental import enable_hist_gradient_boosting
from sklearn.tree import DecisionTreeClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn import  metrics

from imblearn.over_sampling import SMOTE
from sklearn.preprocessing import MinMaxScaler

from sklearn.preprocessing import StandardScaler


root='./'

pnf10=(sio.loadmat(root+'pnf20150.mat'))['pnf20150']
pnf20=(sio.loadmat(root+'pnf20160.mat'))['pnf20160']
pnf30=(sio.loadmat(root+'pnf20170.mat'))['pnf20170']

pnf11=(sio.loadmat(root+'pnf20151.mat'))['pnf20151']
pnf21=(sio.loadmat(root+'pnf20161.mat'))['pnf20161']
pnf31=(sio.loadmat(root+'pnf20171.mat'))['pnf20171']


pnf0=np.vstack((pnf10,pnf20,pnf30))
pnf1=np.vstack((pnf11,pnf21,pnf31))
print(pnf0.shape)
print(pnf1.shape)

val0=pnf0[0:821][:][:]
val1=pnf1[0:1265][:][:]
train0=pnf0[821:4106][:][:]#4106
train1=pnf1[1265:6326][:][:]#6326

y_val0=np.zeros((821,1))
y_val1=np.ones((1265,1))
y_train0=np.zeros((3285,1))
y_train1=np.ones((5061,1))

x_train=np.vstack((train0,train1))
y_train=np.vstack((y_train0,y_train1))

x_val=np.vstack((val0,val1))
y_val=np.vstack((y_val0,y_val1))

[a_xt,b_xt,c_xt]=x_train.shape

[a_xv,b_xv,c_xv]=x_val.shape
x_train=x_train.reshape(a_xt,b_xt*c_xt)
x_val=x_val.reshape(a_xv,b_xv*c_xv)


print(x_train.shape,x_val.shape)

over_samples = SMOTE(random_state=1234) 
over_samples_x,over_samples_y = over_samples.fit_sample(x_train, y_train)##数据平衡

###########classifiers###############
clf = GradientBoostingClassifier().fit(over_samples_x, over_samples_y)

acc=clf.score(x_val, y_val);
sss = clf.predict(x_val)
print('准确率是',acc)
pro_val=clf.predict_proba(x_val)

aa=sss
#numz=len(list(aa))
a0=aa[0:821]
a1=aa[821:2086]
numz00=list(a0).count(0)
numz01=list(a0).count(1)
numz10=list(a1).count(0)
numz11=list(a1).count(1)
num0=len(list(a0))
num1=len(list(a1))

print('敏感性是',numz11/num1)
print('特异性是',numz00/num0)


y_predprob = clf.predict_proba(x_val)[:,1]
print ("AUC Score (Test): %f" % metrics.roc_auc_score(y_val, y_predprob)) #计算AUC的值
   

#保存训练好的模型
from sklearn.externals import joblib
joblib.dump(clf,'model_kong.pkl')

####加载训练好的模型
# from sklearn.externals import joblib
# clf=joblib.load('kong_model.pkl')
# acc=clf.score(x_val, y_val);
# sss = clf.predict(x_val)#输出测试集的预测值
# print('准确率是',acc)
