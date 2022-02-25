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

## Description
**In this project I don't attach HDL code for conversion process input analog signal from microphone using ADC (Analog-Digital Converter)**. I used ADC **16-bit 16kHz** with **I2S** interface for getting digital samples.

Project's code starts off by getting data from **ADC** using **I2S** interface.

Next I built pipeline for extraction features from time-series signal. I was based on Python's library [python_speech_features](https://python-speech-features.readthedocs.io/en/latest/).
As features for the model inputs I used MFCC. (You can learn more [here](http://practicalcryptography.com/miscellaneous/machine-learning/guide-mel-frequency-cepstral-coefficients-mfccs/)).

As speech segments solver I have used DNN with defined structure. Solver get on the input scaling MFCC features and return for each speech segment label: absence human speech or not.
I have trainded the model and I have used calculated weights and biases to develop HDL code using Vivado HLS and C++.

As device input I have used MEMS microphone connected to ADC scheme.
It, in turn, connected to FPGA Kintex 7 pins.

As device output I have used LED indicator connected to FPGA Kintex 7 pins to monitor the processing VAD result.

## Project structure
This repository contain sourse files for realization whole VAD system on FPGA and Jupyter Notebook for presentation result of the model processing, details of the extraction features and common pipeline model processing.
Also I have used Vivado HLS intrument to implement DNN model in FPGA using C++.
It's a simple example of the model architecture description.
The final result is user IP core, which implemented in the Vivado project.

In repository you can find saved model's weights and biases to use for implementation model in the FPGA structure using High-Level synthesis.
It makes possible to change the parameters and strcture the machine learning model.

Bellow you can get acquainted with common structure of this repository.

### Python: MFCC processing pipeline and DNN modeling
In Python part you can find Jupyter Notebook for testing model. Also I'm storing model instance with calculated weights and biases to use it in implementation.
Also I attached some metrics to evaluate the model's processing.
It can be possible to learn it and perform some changes to improve the model processing.
All calculations provided with help python_speech_features library, but when we talk about HDL realization we need to jump right in 

#### MFCC pipeline:
Steps to get MFCC:
1. Pre-emphasis or filtering:

A pre-emphasis filter is useful in several ways: balance the frequency spectrum since high frequencies usually have smaller magnitudes compared to lower frequencies, avoid numerical problems during the FFT and also improve the Signal-to-Noise Ratio (SNR).

```math
SE = \frac{\sigma}{\sqrt{n}}
```







### C++: Vivado HLS implemantation
Used Vivado HLS and C++.

TO DO smth


### FPGA: VAD realization
I divided the Vivado project on the parts.
I attached the image below for more comfortable learning the structure.

![Project structure](https://github.com/AlexKly/Simple-Voice-Activity-Detector-using-MFCC-based-on-FPGA-Kintex/blob/master/Docs/Project%20structure.drawio.png "Project structure")

#### Vivado project structure:
* Common modules: main file (Vega_submain.v) and I2S receiver (capture_audio_sample.v)
* MFCC features pipeline part: you can find in 'Calculation MFCC features' for calculation MFCC features and delta for model's inputs
* Machine learning pipeline part: implementation DNN module like a IP core generated using Vivado HLS
* IP cores: all IP cores using in this project
* TestBench: file (tb_Vega_submain.vhd) to test the whole project

The intance of the LED indication using DNN solver signal:
~~~
VAD_module: Vega_submain
    port map (
        g_fast_clk  => S_AXI_ACLK,
        bclk        => bclk_in,
        wclk        => wclk_in,
        d_audio     => d_audio_in,
        DNN_Done    => DNN_Done,
        DNN_Result  => DNN_Result
    );
        
process(DNN_Done) begin
    if rising_edge(DNN_Done) then
        if (DNN_Result = '0') then
            Marker_On_LED_1 <= '0';
        else
            Marker_On_LED_1 <= '1';
        end if;
    end if;
end process;
~~~
Add it in the main part and connect to FPGA output pin.

### Data
So, I operated with preprocessed dataset. I have used data from [this](https://www.kaggle.com/c/silero-audio-classifier/data) Kaggle competitions.
I processed wav files with sampling rate is equal to 16000.

## Processing result machine learning model

## Implemantation result Vivado HLS

## Simulation the FPGA realization

## Demonstration and results

## Extra

