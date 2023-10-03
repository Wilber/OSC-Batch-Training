#!/usr/bin/env python
# coding: utf-8



#Heavily adapted from: https://thecleverprogrammer.com/2022/01/10/classification-with-neural-networks-using-python/ 

#Load important libraries
import tensorflow as tf
from tensorflow import keras
import numpy as np


#Import fashion MNIST dataset
#Also found here: https://www.kaggle.com/datasets/zalando-research/fashionmnist
fashion = keras.datasets.fashion_mnist
(xtrain, ytrain), (xtest,ytest) = fashion.load_data()


#xtrain.shape


#Now build a neural network architecture with two hidden layers:
model = keras.models.Sequential([
    keras.layers.Flatten(input_shape = [28,28]),
    keras.layers.Dense(300, activation = "relu"),
    keras.layers.Dense(100, activation = "relu"),
    keras.layers.Dense(10, activation = "softmax")
])

print(model.summary())


#split the training data into training and validation sets:
xvalid, xtrain = xtrain[:5000]/255.0, xtrain[5000:]/255.0
yvalid, ytrain = ytrain[:5000], ytrain[5000:]



#model compilation
model.compile(loss="sparse_categorical_crossentropy",
              optimizer="sgd",
              metrics=["accuracy"])



#fit model to data (Train neural net)
history = model.fit(xtrain, ytrain, epochs=100, 
                    validation_data=(xvalid, yvalid))


#model evaluation
score = model.evaluate(xtest, ytest, verbose = 0)
print('Test loss:', score[0])                                                                                                                                                                 
print('Test accuracy:', score[1])



#predictions

new = xtest[:5]
predictions = model.predict(new)
print(predictions)




#predicted classes

classes = np.argmax(predictions, axis=1)
print(classes)
