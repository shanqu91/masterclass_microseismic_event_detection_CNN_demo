
Run:
octave A_segmentation_labelling_train_dev_data.m &  -> label and segment train+dev data;
python B_CNN.py                                     -> training;
octave C_segmentation_test_data.m &                 -> segment test data;
python D_predict.py                                 -> predict the test data
octave E_check_pred_test_data.m &                   -> visualize the predicted results
