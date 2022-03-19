# Simple Voice Activity Detector (VAD) using MFCC features based on FPGA Kintex 7
## Introducing
The **Voice Activity Detector** is detection system of the presence or absence of human speech segments in input audio signal, used in the speech processing systems.
To perform classification the speech into two classes, the system need to process input audio samples in to features containing hidden infomation about speech.
And then the system can classifier several segments based on get features using Machine Learning approches.

This my first and test version of the **VAD** based on the FPGA **Kintex 7**.
This version is not optimized in terms of FPGA resoures and I used quite simple model to reach the classification task.
However, the huge reserves of Kintex resourses make it possible to try different structures of algoritms that are not resourse-optimized.

The need to implement this algoritm based on FPGA is closely related to the need of the realization whole complex Speech Recognition system for the Smart Home tasks.
And further works I will use more complex Deep Learning models to classification speech and more optimized structure for realization on FPGA.

You can find the new version with ***BiLSTM*** and ***CNN-BiLSTM*** [here](https://github.com/AlexKly/VegaVAD).

## Description
**In this project I don't attach HDL code for conversion process input analog signal from microphone using ADC (Analog-Digital Converter)**. I used ADC **16-bit 16kHz** with **I2S** interface for getting digital samples.

Project's code starts off by getting data from **ADC** using **I2S** interface.

Next I built pipeline for extraction features from time-series signal. I was based on *Python's* library [python_speech_features](https://python-speech-features.readthedocs.io/en/latest/).
As features for the model inputs I used **MFCC**. (You can learn more [here](http://practicalcryptography.com/miscellaneous/machine-learning/guide-mel-frequency-cepstral-coefficients-mfccs/)).

As speech segments solver I have used **DNN** with defined structure. Solver get on the input scaling **MFCC** features and return for each speech segment label: absence human speech or not.
I have trainded the model and I have used calculated weights and biases to develop HDL code using *Vivado HLS* and *C++*.

As device input I have used MEMS microphone connected to ADC scheme.
It, in turn, connected to FPGA **Kintex 7** pins.

As device output I have used LED indicator connected to FPGA **Kintex 7** pins to monitor the processing VAD result.

## Project structure
This repository contain sourse files for realization whole VAD system on FPGA and Jupyter Notebook for presentation result of the model processing, details of the extraction features and common pipeline model processing.
Also I have used *Vivado HLS* intrument to implement **DNN** model in FPGA using *C++*.
It's a simple example of the model architecture description.
The final result is user IP core, which implemented in the *Vivado* project.

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

A pre-emphasis filter is useful in several ways: balance the frequency spectrum since high frequencies usually have smaller magnitudes compared to lower frequencies, avoid numerical problems during the **FFT** and also improve the **Signal-to-Noise** Ratio (**SNR**).

<img src="https://latex.codecogs.com/png.image?\dpi{120}&space;\bg_white&space;y(t)&space;=&space;x(t)&space;-&space;\alpha&space;x(t&space;-&space;1)" title="\bg_white y(t) = x(t) - \alpha x(t - 1)" />

where `x(t)` - original (input) signal,

`y(t)` - preemphased (output) signal,

`alpha` - filter coefficient. Typical values are 0.95 - 0.97.

Bellow are the graphs of the signal before and after filtering:

![Original signal](https://github.com/AlexKly/Simple-Voice-Activity-Detector-using-MFCC-based-on-FPGA-Kintex/blob/master/Docs/MFCC%20pipeline%20graphics/Original%20signal.PNG "Original signal")
![Pre-emphased signal](https://github.com/AlexKly/Simple-Voice-Activity-Detector-using-MFCC-based-on-FPGA-Kintex/blob/master/Docs/MFCC%20pipeline%20graphics/Pre-emphased%20signal.PNG "Pre-emphased signal")

2. Framing:

After pre-emphasis, we need to split signal into short-time frames. 
The rationale behind this step is that frequencies in a signal change over time, so in most cases it doesn’t make sense to do the Fourier transform across the entire signal in that we would lose the frequency contours of the signal over time.
To avoid that, we can safely assume that frequencies in a signal are stationary over a very short period of time.
Therefore, by doing a Fourier transform over this short-time frame, we can obtain a good approximation of the frequency contours of the signal by concatenating adjacent frames.

Bellow is the graph of the single frame:
![Single frame](https://github.com/AlexKly/Simple-Voice-Activity-Detector-using-MFCC-based-on-FPGA-Kintex/blob/master/Docs/MFCC%20pipeline%20graphics/Single%20frame.PNG "Single frame")

3. Window:

After framing the signal, we apply a window function to each frame (In our case it's Hamming window function).

There are several reasons why we need to apply a window function to the frames, notable to counteract the assumption made by the **FFT** that the data if infinite and to reduce spectral leakage.

4. Fourier-Transform and Power Spectrum:

After windowing each frame we can do an N-point **FFT** on each frame to calculate the frequency spectrum, which is also called **Short-Time Fourier-Transform** (**STFT**).
And then compute the power spectrum using the following equation:

<img src="https://latex.codecogs.com/png.image?\dpi{120}&space;\bg_white&space;P&space;=&space;\frac{\left|&space;FFT(x_i)&space;\right|^2}{N}" title="\bg_white P = \frac{\left| FFT(x_i) \right|^2}{N}" />

where `x_i` is the i-th frame of signal x(t),

`N` - number of the points FFT.

Bellow is the graph of the power spectrum:

![Power spectrum](https://github.com/AlexKly/Simple-Voice-Activity-Detector-using-MFCC-based-on-FPGA-Kintex/blob/master/Docs/MFCC%20pipeline%20graphics/Power%20spectrum.PNG "Power spectrum")

5. Energy on frame:
After calculation power spectrum, we need to calculate energy per frame and to append to **MFCC** vector later.

To calculate energe om the frame, we use following equation:

<img src="https://latex.codecogs.com/png.image?\dpi{120}&space;\bg_white&space;E&space;=&space;\sum_{i}^{FrameLength}P_i" title="\bg_white E = \sum_{i}^{FrameLength}P_i" />

where `P_i` - power spectrum on the i-th frame,

`FrameLength` - Samples number in the frame.

The graph of the energy changing on the frames is shown bellow:
![Energy of the signal](https://github.com/AlexKly/Simple-Voice-Activity-Detector-using-MFCC-based-on-FPGA-Kintex/blob/master/Docs/MFCC%20pipeline%20graphics/Energy%20on%20frame.PNG "Energy of the signal")

Eventually, we need to apply log operation to energy massive.

6. Filter Banks:

The final step to computing **filter banks** is applying triangular filters on a Mel-scale to the power spectrum to extract frequency bands.
The Mel-scale aims to mimic the non-linear human ear perception of sound, by being more discriminative at lower frequencies and less discriminative at higher frequencies.
We can convert between Hertz (f) and Mel (m) using the following equations:

<img src="https://latex.codecogs.com/png.image?\dpi{120}&space;\bg_white&space;m&space;=&space;2595log_{10}(1&plus;\frac{f}{700})&space;" title="\bg_white m = 2595log_{10}(1+\frac{f}{700}) " />

<img src="https://latex.codecogs.com/png.image?\dpi{120}&space;\bg_white&space;f&space;=&space;700(10^{\frac{m}{2595}}&space;-&space;1)" title="\bg_white f = 700(10^{\frac{m}{2595}} - 1)" />

Each filter in the filter bank is triangular having a response of 1 at the center frequency and decrease linearly towards 0 till it reaches the center frequencies of the two adjacent filters where the response is 0, as shown in this figure:

![Filter bank on a Mel-Scale](https://github.com/AlexKly/Simple-Voice-Activity-Detector-using-MFCC-based-on-FPGA-Kintex/blob/master/Docs/MFCC%20pipeline%20graphics/Filter%20bank%20on%20a%20Mel-Scale.PNG "Filter bank on a Mel-Scale")

This can be modeled by the following equation (taken from here):

<img src="https://latex.codecogs.com/png.image?\dpi{120}&space;\bg_white&space;H_{m}(k)&space;=&space;\begin{cases}0&space;&&space;\text{&space;if&space;}&space;k&space;<&space;f(m&space;-&space;1)&space;\\\frac{k&space;-&space;f(m&space;-&space;1)}{f(m)&space;-&space;f(m&space;-&space;1)}&space;&&space;\text{&space;if&space;}&space;f(m&space;-&space;1)&space;\leqslant&space;k&space;<&space;f(m)&space;\\1&space;&&space;\text{&space;if&space;}&space;k&space;=&space;f(m)&space;\\\frac{f(m&space;&plus;&space;1)&space;-&space;k}{f(m&space;&plus;&space;1)&space;-&space;f(m)}&space;&&space;\text&space;{&space;if&space;}&space;f(m)&space;<&space;k&space;\leq&space;&space;f(m&plus;1)&space;\\0&space;&&space;\text&space;{&space;if&space;}&space;k&space;>&space;f(m&space;&plus;&space;1)\end{cases}" title="\bg_white H_{m}(k) = \begin{cases}0 & \text{ if } k < f(m - 1) \\\frac{k - f(m - 1)}{f(m) - f(m - 1)} & \text{ if } f(m - 1) \leqslant k < f(m) \\1 & \text{ if } k = f(m) \\\frac{f(m + 1) - k}{f(m + 1) - f(m)} & \text { if } f(m) < k \leq f(m+1) \\0 & \text { if } k > f(m + 1)\end{cases}" />

After applying the filter bank to the power spectrum of the signal, we obtain the following spectrogram:

![Spectrogram of the Signal](https://github.com/AlexKly/Simple-Voice-Activity-Detector-using-MFCC-based-on-FPGA-Kintex/blob/master/Docs/MFCC%20pipeline%20graphics/FilterBanks%20Spectrogram.PNG "Spectrogram of the Signal")

7. Mel-frequency Cepstral Coefficients (MFCCs):

It turns out that filter bank coefficients computed in the previous step are highly correlated, which could be problematic in some machine learning algorithms.
Therefore, we can apply **Discrete Cosine Transform** (**DCT**) to decorrelate the filter bank coefficients and yield a compressed representation of the filter banks.

The resulting **MFCCs**:
![MFCCs](https://github.com/AlexKly/Simple-Voice-Activity-Detector-using-MFCC-based-on-FPGA-Kintex/blob/master/Docs/MFCC%20pipeline%20graphics/MFCC%20spectrogram.PNG "MFCCs")

8. Deltas:

Also known as differential and acceleration coefficients.
The MFCC feature vector describes only the power spectral envelope of a single frame, but it seems like speech would also have information in the dynamics i.e. what are the trajectories of the **MFCC** coefficients over time.
It turns out that calculating the **MFCC** trajectories and appending them to the original feature vector increases ASR performance by quite a bit (if we have 12 **MFCC** coefficients, we would also get 12 **delta** coefficients, which would combine to give a feature vector of length 24).

To calculate the **delta** coefficients, the following formula is used:

<img src="https://latex.codecogs.com/png.image?\dpi{120}&space;\bg_white&space;d_{t}&space;=&space;\frac{\sum_{n=1}^{N}n(c_{t&space;&plus;&space;n}&space;-&space;c_{t&space;-&space;n})}{2\sum_{n=1}^{N}n^{2}}" title="\bg_white d_{t} = \frac{\sum_{n=1}^{N}n(c_{t + n} - c_{t - n})}{2\sum_{n=1}^{N}n^{2}}" />

where `d_t` is a delta coefficient, from frame t computed in terms of the static coefficients `c_{t+N}`  to `c_{t-N}`.
A typical value for `N` is 2. **Delta-Delta** (*Acceleration*) coefficients are calculated in the same way, but they are calculated from the **deltas**, not the static coefficients.

The result combined **MFCC** and **Delta-Delta** is shown bellow:
![MFCC + Deltas](https://github.com/AlexKly/Simple-Voice-Activity-Detector-using-MFCC-based-on-FPGA-Kintex/blob/master/Docs/MFCC%20pipeline%20graphics/MFCC%2BDeltas%20spectrogram.PNG "MFCC + Deltas")

### C++: Vivado HLS implemantation
The *Vivado HLS* is quick and quiet simple approach to implement the **DNN** model in FPGA.
When the model is learnt you can get model's weights and biases.
Next, you can code `predict()` funtion (forward propagation) using *C++*.

After ascertain that C++ code works right, we can go to the next step.
The Vivado HLS generate achive with your model implementaion like a archive which you can use in the Vivado project.

Below is shown resources required by the module and module's structure of the input/output ports:

![Utilization Estimates](https://github.com/AlexKly/Simple-Voice-Activity-Detector-using-MFCC-based-on-FPGA-Kintex/blob/master/Docs/Vivado%20HLS%20Sythesis%20Summary/Utilization%20Estimates.PNG)

![Interface](https://github.com/AlexKly/Simple-Voice-Activity-Detector-using-MFCC-based-on-FPGA-Kintex/blob/master/Docs/Vivado%20HLS%20Sythesis%20Summary/Interface.PNG)

It's really not optimized method for design, but I use the Kintex 7 and I don't worry about resourser in my test project because it has really a huge logic unit number.

Also I attached links to tutorial how to use Vivado HLS: 
* [Tutorial](https://www.so-logic.net/documents/upload/Basic_HLS_Tutorial.pdf)
* [Xilinx documentation](https://www.xilinx.com/support/documentation/sw_manuals/xilinx2014_2/ug871-vivado-high-level-synthesis-tutorial.pdf)

Later, it will be described how to add the generated module to the project.

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

## Requirement
### Hardware:
* Kintex 7 (xc7ktffg900-2) on the factory board (processing unit)
* ADC 16-bit with I2S interface on factory board (convertion analog audio)
* MEMS micro or micro jack for debug audio from PC (input analog audio)
* Resistor 500 Omh (for connection LED)
* Red LED (for indication)

### Soft:
* Anaconda (Jupyter Notebook)
* Visual Studio 2019
* Vivado 2016.2
* Vivado HLS 2016.2

## Processing result machine learning model
In the modeling part we can select satisfying model structure for VAD.
In the *DNN modeling.ipynb* I perform preparation data to fit the model and estimate results several DNN structures.
The binary classification mean accuracy is fluacting between 0.8 - 0.9 depended from structure.
I have used accuracy and ROC-AUC metrics to estimate models.

You can see plots with result of the processing VAD alghorithm on the validation real signal and ROC-AUC curves for several estimated models.

![VAD result](https://github.com/AlexKly/Simple-Voice-Activity-Detector-using-MFCC-based-on-FPGA-Kintex/blob/master/Docs/DNN%20modeling/VAD%20result.PNG)

![ROC-AUC curve](https://github.com/AlexKly/Simple-Voice-Activity-Detector-using-MFCC-based-on-FPGA-Kintex/blob/master/Docs/DNN%20modeling/AUC-ROC%20result.PNG)

In the *DNN modeling.ipynb* I prepared printing the C++ arrays with model weights to simplify transfer it in C++ code.
You can see that the DNN processing results is not perfect and there are enough Type I errors (False positive) and Type II errors (False negative), but it's appropriate for me.

## Implemantation result Vivado HLS
Not yet

## Simulation the FPGA realization
Not yet

## Demonstration and results
Not yet

## Extra
Not yet

