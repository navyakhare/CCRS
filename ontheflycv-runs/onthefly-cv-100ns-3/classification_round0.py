import numpy as np
import matplotlib.pyplot as plt
import simtk.openmm as mm

import pandas as pd 
from pandas import DataFrame 
from sklearn import datasets 

from sklearn.covariance import EllipticEnvelope

import pickle

inputData = np.loadtxt('input_ANC.dat',dtype='str')

colvar = np.loadtxt(inputData[0])
version = inputData[1]

allcvs = colvar[:,1:7]

train = pd.DataFrame(allcvs) 

estimator_EE = EllipticEnvelope()

estimator_EE.fit(train)

filename = 'EE_model_'+str(version)+'.sav'
pickle.dump(estimator_EE, open(filename, 'wb'))

EE_model_list=open('EE_model_list.dat','w')
EE_model_list.write('EE_model_'+str(version)+'.sav\n')
EE_model_list.write('EE_model_'+str(version)+'.sav\n')
