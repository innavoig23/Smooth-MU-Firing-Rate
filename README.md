# Smooth-MU-Firing-Rate

After HD-sEMG decomposition, various analysis can be done. Among them, Motor Unit (MU) firing rate is usually inspected.
A part from computing the so called Instantaneous Discharge Rate (IDR), it is often computed and investigated its smoothed form. As classically done in many studies, I implemented the smoothing with a Hanning window of 400 ms as proposed firstly by [de Luca](http://dx.doi.org/10.1113/jphysiol.1982.sp014293). I decided to do that since I didn't find any "official" version on the internet.

This script was used in my [**MSc Thesis at Politecnico di Torino**](https://webthesis.biblio.polito.it/33655/), which focused on analyzing MU behavior and functional performance in patients with brachial plexus injuries following nerve transfer surgery.

Just a quick note: In this function MUPulses has a structure as the output from [DEMUSE®](https://demuse.feri.um.si/). It is a cell 1xN, where N is the number of identified MUs. Each cell contain a vector with variable length, where each element represent the sample when the MU spiked.
