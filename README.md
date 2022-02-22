# Simple Voice Activity Detector (VAD) using MFCC features based on FPGA Kintex 7
## Introducing
The Voice Activity Detector is detection system of the presence or absence of human speech segments in input audio signal, used in the speech processing systems.
To perform classification the speech in to two classes, the system need to process input audio samples in to features containing hidden infomation about speech.
And then the system can classifier several segments based on get features using Machine Learning approches.

This my first and test version of the VAD based on the FPGA Kintex 7.
This version is not optimized in terms of FPGA resoures and I used quite simple model to reach the classification task.
However, the huge reserves of Kintex resourses make it possible to try different structures of algoritms that are not resourse-optimized.

The need to implement this algoritm based on FPGA is closely related to the need of the realization whole complex Speech Recognition system for the Smart Home tasks.
And further works I will use more complex Deep Learning models to classification speech and more optimized structure for realization on FPGA.

You can find the new version with ***BiLSTM*** and ***CNN-BiLSTM*** [here](https://github.com/AlexKly/VegaVAD).

## Project structure
This repository contain sourse files for realization whole VAD system on FPGA and Jupyter Notebook for presentation result of the model processing, details of the extraction features and common pipeline model processing.
Also I have used Vivado HLS intrument to implement DNN model in FPGA using C++. It's a simple example of the model architecture description. The final result is user IP core, which implemented in the Vivado project.

Bellow you can get acquainted with common structure of this repository.

### FPGA


### Python


### C++ 


### Data
So, I operated with preprocessed dataset. I have used data from [this](https://www.kaggle.com/c/silero-audio-classifier/data) Kaggle competitions.
I processed wav files with sampling rate is equal to 16000.


## 
