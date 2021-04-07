import keras
from keras.models import Sequential, load_model, Model
from keras.layers import Dense, Dropout, Flatten
from keras.layers import Conv2D, MaxPooling2D
from keras.layers import Input
from scipy import io

num_classes = 2                                 # number of classes for the classification
batch_size = 40                                 # number of samples per gradient update (for mini-batch gradient-based algorithms)
epochs = 2                                     # number of iterations
loss = keras.losses.categorical_crossentropy    # loss function
optimizers = keras.optimizers.Adadelta()        # optimization algorithm,
                                                # an Adaptive Learning Rate Method is used here, so no need to set training rate ;-)
metrics=['accuracy']                            # metrics:    a function that is used to judge the performance of your model,
                                                # mean squared error is used here

######## load train and development data for training ########
mat_contents = io.loadmat('Data/X_train.mat')
X_train = mat_contents['X_train']
mat_contents = io.loadmat('Data/Y_train.mat')
Y_train = mat_contents['Y_train']
mat_contents = io.loadmat('Data/X_dev.mat')
X_dev = mat_contents['X_dev']
mat_contents = io.loadmat('Data/Y_dev.mat')
Y_dev = mat_contents['Y_dev']

train_datasize, patch_rows, patch_cols = X_train.shape[0], X_train.shape[1], X_train.shape[2]
dev_datasize = X_dev.shape[0]
X_train = X_train.reshape(train_datasize, patch_rows, patch_cols, 1)
X_dev = X_dev.reshape(dev_datasize, patch_rows, patch_cols, 1)

Y_train = keras.utils.to_categorical(Y_train, num_classes)
Y_dev = keras.utils.to_categorical(Y_dev, num_classes)

print('X_train shape:', X_train.shape)
print('Y_train shape:', Y_train.shape)

######## specify the CNN architecture ########
model = Sequential()
input_data = Input(shape=(patch_rows, patch_cols, 1))
conv1 = Conv2D(32,
               kernel_size=(3, 3),
               padding='same',
               activation='relu',
               kernel_initializer='glorot_uniform')(input_data)
conv1 = Conv2D(32,
               kernel_size=(3, 3),
               padding='same',
               activation='relu',
               kernel_initializer='glorot_uniform')(conv1)
pool1 = MaxPooling2D(pool_size=(10, 10))(conv1)

dense0 = Flatten()(pool1)
dense1 = Dense(128, activation='relu')(dense0)
dense1 = Dropout(0.6)(dense1)
dense2 = Dense(128, activation='relu')(dense1)
output_data = Dense(num_classes, activation='softmax')(dense2)

model = Model(inputs=input_data, outputs=output_data)
print(model.summary())

######## specify the inversion algorithm ########
model.compile(loss=loss,
              optimizer=optimizers,
              metrics=['accuracy'])

######## training ########
model.fit(X_train, Y_train,
          batch_size=batch_size,
          epochs=epochs,
          verbose=1,
          validation_data=(X_dev, Y_dev))
model.save('Data/trained_model.h5')

