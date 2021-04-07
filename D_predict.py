import keras
from keras.models import Sequential, load_model, Model
from keras.layers import Dense, Dropout, Flatten
from keras.layers import Conv2D, MaxPooling2D
from scipy import io

mat_contents = io.loadmat('Data/X_test_0.mat')
X_test_0 = mat_contents['X_test_0']
mat_contents = io.loadmat('Data/X_test_1.mat')
X_test_1 = mat_contents['X_test_1']

batch_size = 40
num_classes = 2

test_datasize, patch_rows, patch_cols = X_test_0.shape[0], X_test_0.shape[1], X_test_0.shape[2]
X_test_0 = X_test_0.reshape(test_datasize, patch_rows, patch_cols, 1)
test_datasize, patch_rows, patch_cols = X_test_1.shape[0], X_test_1.shape[1], X_test_1.shape[2]
X_test_1 = X_test_1.reshape(test_datasize, patch_rows, patch_cols, 1)

print('X_test_0 shape:', X_test_0.shape)
print('X_test_1 shape:', X_test_1.shape)

# load trained model
model = load_model('Data/trained_model.h5')

# prediction
Y_test_0 = model.predict(X_test_0, batch_size=batch_size, verbose=1)
Y_test_1 = model.predict(X_test_1, batch_size=batch_size, verbose=1)

io.savemat('Data/Y_test_0.mat', {'Y_test_0':Y_test_0})
io.savemat('Data/Y_test_1.mat', {'Y_test_1':Y_test_1})
