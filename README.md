# PolarCodesBeliefPropagationDecoder
MATLAB codes for polar BP decoder. It is just a very simple BP decoder. I hope it would be useful for new learners of polar codes.

MATLAB_Polar_BP_conventional is a quicker version.
This Bp decoder for polar codes is relatively quick.
I store the indices that are frequently used in decoding process in matrices. Therefore, redundant calculations are avoided.
Besides, the so-called G-matrix early stopping criterion (proposed by Yuan BO) is included.
With above configurations, for P(1024, 512), 10^4 codewords can be encoded/decoded with in 25s on a common PC. 
That is to say, 1.44*10^6 decodings can be done in an hour. This speed is enough for BLER simulations.

If you have any question to my codes or have problems in polar codes, you can email me 498699845@qq.com.
Let us study polar codes together.
However, my math is just-so-so. Don't ask me polar codes error exponent or scaling behavior. I don't know that....
