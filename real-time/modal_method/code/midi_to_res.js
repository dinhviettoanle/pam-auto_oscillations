
var w1 = 0;
var Q1 = 0
var w2 = 0;
var Q2 = 0;
var w3 = 0;
var Q3 = 0;
var w4 = 0;
var Q4 = 0;
var w5 = 0;
var Q5 = 0;
var F = 0;

inlets = 1;
outlets = 12;

function msg_int(v)
{
	midi_in = v;
	
	
	if (midi_in == 57) {
		w1 = 1387.33;
		Q1 = 82.59;
		w2 = 4177.06;
		Q2 = 50.33;
		w3 = 6971.82;
		Q3 = 33.76;
		w4 = 9771.61;
		Q4 = 25.14;
		w5 = 12576.42;
		Q5 = 19.96;
		F = 1864.82;
	}

	else if (midi_in == 59) {
		w1 = 1563.26;
		Q1 = 75.71;
		w2 = 4704.85;
		Q2 = 41.37;
		w3 = 7856.49;
		Q3 = 27.03;
		w4 = 11013.17;
		Q4 = 19.91;
		w5 = 14179.89;
		Q5 = 15.72;
		F = 2113.66;
	}
		
	outlet(1, w1);
	outlet(2, Q1);
	outlet(3, w2);
	outlet(4, Q2);
	outlet(5, w3);
	outlet(6, Q3);
	outlet(7, w4);
	outlet(8, Q4);
	outlet(9, w5);
	outlet(10, Q5);
	outlet(11, F);
}
