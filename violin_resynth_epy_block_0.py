import numpy as np
from gnuradio import gr

class blk(gr.sync_block):
    def __init__(self, max_angle=45.0, max_offset=100.0):
        gr.sync_block.__init__(
            self,
            name='Tuning Compass Controller',
            in_sig=[np.float32, np.float32],
            out_sig=[np.float32]
        )
        self.max_angle = max_angle      # maximum angle to rotate compass (deg)
        self.max_offset = max_offset    # offset in Hz that maps to max angle

    def work(self, input_items, output_items):
        in0 = input_items[0]  # measured frequency
        in1 = input_items[1]  # reference frequency
        out = output_items[0]

        for i in range(len(out)):
            offset = in0[i] - in1[i]  # Positive = tune down, negative = tune up

            offset = max(-self.max_offset, min(offset, self.max_offset))

            angle = (offset / self.max_offset) * self.max_angle

            out[i] = angle

        return len(out)