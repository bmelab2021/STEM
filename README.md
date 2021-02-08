# STEM
The code for our paper in Communications Biology:

## Development of Deep Learning Algorithms for Predicting Balstocyst Formation and Quality by Time-lapse Monitoring, Qiuyue Liao, Qi Zhang, Xue Feng, Haibo Huang, Haohao Xu, Baoyuan Tian,Jihao Liu, Qihui Yu, Na Guo, Qun Liu, Bo Huang, Ding Ma, Jihui Ai, Shugong Xu and Kezhen Li.

## Required libraries:  
matlab r2019a  
python 3.7  
numpy 1.18.5  
scipy 1.5.0  
scikit-learn 0.20.4  
opencv-python 4.2.0  
imbalanced-learn 0.2.0  

## Steps:  
1.Preprocess the video data    
  
2.Use the temporal_model.py to train the temporal stream model and get the output of the model  
  
3.Use the spatial_model.py to train the spatial stream model and get the output of the model  
  
4.Use the get_weight_value.m and ensemble_weight.m to get the output prediction value of the spatial and temporal stream model by their weight.  

