"""
Embedded Python Blocks:

Each time this file is saved, GRC will instantiate the first class it finds
to get ports and parameters of your block. The arguments to __init__  will
be the parameters. All of them are required to have default values!
"""

import numpy as np
from gnuradio import gr


class blk(gr.sync_block):  # other base classes are basic_block, decim_block, interp_block
    """Embedded Python Block example - a simple multiply const"""

    def __init__(self, samp_rate = 1024, fft_size = 1024):  # only default arguments here
        """arguments to this function show up as parameters in GRC"""
        gr.sync_block.__init__(
            self,
            name='Custom Peak Detector',   # will show up in GRC
            in_sig=[(np.complex64, fft_size)],
            out_sig=[np.float32]
        )
        # if an attribute with the same name as a parameter is found,
        # a callback is registered (properties work, too).
        self.samp_rate = samp_rate
        self.fft_size = fft_size


    def work(self, input_items, output_items):
        """example: multiply with constant"""
        # mag = np.abs(self.fft_data) / self.fft_size
        freqs = np.fft.fftfreq(self.fft_size, d = 1 / self.samp_rate)
        amplitude = np.abs(input_items[:][0])
        max_amplitude = np.argmax(amplitude)
        peak_freq = freqs[max_amplitude]
        output_items[0][:] = peak_freq * np.ones(input_items[0].shape[0]) + 16000

        return len(output_items[0][:])
        # return peak_freq * input_items.shape[0]