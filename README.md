# Smooth Motor Unit (MU) Firing Rate

After HD-sEMG decomposition, various analyses can be performed. One of the most commonly studied features is the **firing rate of Motor Units (MUs)**.  
In addition to the **Instantaneous Discharge Rate (IDR)**, its **smoothed** form is often used.  

A widely adopted approach for smoothing the firing rate is the application of a **400 ms Hanning window**, as first proposed by [De Luca et al. (1982)](http://dx.doi.org/10.1113/jphysiol.1982.sp014293). However, I could not find an "official" MATLAB implementation of this method online, so I decided to implement it myself.

This script was used in my [**MSc Thesis at Politecnico di Torino**](https://webthesis.biblio.polito.it/33655/), where I analyzed MU behavior and functional performance in patients with **brachial plexus injury** following **nerve transfer surgery**.

## **📌 Usage**
Input Data:
- `MUPulses`: 1 × N cell array, where `N` is the number of identified MUs; each cell contains a variable-length vector, where each element represents the sample index at which the MU fired. This function expects `**MUPulses**` to follow the same structure as the output from [DEMUSE®](https://demuse.feri.um.si/).
- `fsamp`: Sampling frequency of the HD-sEMG signals (Hz).
- `sigLen` *(optional)*: Total length of the signal in samples. Providing `sigLen` is recommended for easier batch processing of multiple files.

To compute the smoothed firing rate:
```matlab
sIDR = smoothFiringRateMU(MUPulses, fsamp, sigLen);
```

where `sIDR` is numMUs × sigLen matrix, where each row contains the smoothed instantaneous discharge rate (pps) of the corresponding MU over time.

## **📌 Example Plots**
Below are two example plots showing the smoothed firing rate of MUs using a 400 ms Hanning window.

### **Example 1:**
![Example 1](/Images/exMU1.png)

### **Example 2**
![Example 2](/Images/exMU2.png)
