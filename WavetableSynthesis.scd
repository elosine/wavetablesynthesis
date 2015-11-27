(
s.waitForBoot{
	fork{
		~wsb = SoundFile.collectIntoBuffers("/Users/jyang/GitHub/wavetablesynthesis/wavetables/*",s,); //load wavetables into buffers
		SynthDef(\waveshape_test, {
			arg pitch=60, buf, numbuf=32;
			var sig, freq, offset;
			offset = MouseX.kr(0.0, numbuf).poll;
			freq = pitch.midicps;
			sig = VOsc3.ar(buf+offset, freq+[0,1],freq+[0.37,1.1],freq+[0.43, -0.29], 0.333333);
			Out.ar(0, sig);
		}).add;
		SynthDef(\wavtab_test, {
			arg pitch=60, ibuf;
			var sig, freq, offset;
			offset = MouseX.kr().poll;
			freq = pitch.midicps;
			sig = VOsc3.ar(ibuf+offset, freq+[0,1],freq+[0.37,1.1],freq+[0.43, -0.29], 0.333333);
			Out.ar(0, sig);
		}).add;
		SynthDef(\wavtab, {
			arg pitch=60, ibuf, offset=0.5;
			var sig, freq;
			freq = pitch.midicps;
			sig = VOsc3.ar(ibuf+offset, freq+[0,1],freq+[0.37,1.1],freq+[0.43, -0.29], 0.333333);
			Out.ar(0, sig);
		}).add;
	}//end fork
}//end s.waitForBoot
)
a = Synth(\waveshape_test, [\buf, ~wsb[0].bufnum, \numbuf, ~wsb.size]);
a.free;
~wsb[75];
~wsb[40];
b = Buffer.read(s, "/Users/jyang/GitHub/synthesisrecipies/WavetableSynthesis/ArchitectureWaveforms/WT23.aif");
c = Buffer.read(s, "/Users/jyang/GitHub/synthesisrecipies/WavetableSynthesis/ArchitectureWaveforms/Pulse Bi Square 1-4th.wav");
d = Synth(\wavtab_test, [\ibuf, b.bufnum]);
d.free;
e = Synth(\wavtab, [\ibuf, b.bufnum, \offset, 0.43]);
e.set(\pitch, 42);
e.set(\pitch, 77);
e.free;

