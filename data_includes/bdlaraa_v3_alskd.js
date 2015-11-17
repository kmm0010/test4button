
var answerHashTable = {};
answerHashTable["blbrdldr"] = ["B L", "B R", "D L", "D R"]
answerHashTable["blbrdrdl"] = ["B L", "B R", "D R", "D L"]
answerHashTable["bldlbrdr"] = ["B L", "D L", "B R", "D R"]
answerHashTable["bldldrbr"] = ["B L", "D L", "D R", "B R"]
answerHashTable["bldrbrdl"] = ["B L", "D R", "B R", "D L"]
answerHashTable["bldrdlbr"] = ["B L", "D R", "D L", "B R"]
answerHashTable["brbldldr"] = ["B R", "B L", "D L", "D R"]
answerHashTable["brbldrdl"] = ["B R", "B L", "D R", "D L"]
answerHashTable["brdlbldr"] = ["B R", "D L", "B L", "D R"]
answerHashTable["brdldrbl"] = ["B R", "D L", "D R", "B L"]
answerHashTable["brdrbldl"] = ["B R", "D R", "B L", "D L"]
answerHashTable["brdrdlbl"] = ["B R", "D R", "D L", "B L"]
answerHashTable["dlblbrdr"] = ["D L", "B L", "B R", "D R"]
answerHashTable["dlbldrbr"] = ["D L", "B L", "D R", "B R"]
answerHashTable["dlbrbldr"] = ["D L", "B R", "B L", "D R"]
answerHashTable["dlbrdrbl"] = ["D L", "B R", "D R", "B L"]
answerHashTable["dldrblbr"] = ["D L", "D R", "B L", "B R"]
answerHashTable["dldrbrbl"] = ["D L", "D R", "B R", "B L"]
answerHashTable["drblbrdl"] = ["D R", "B L", "B R", "D L"]
answerHashTable["drbldlbr"] = ["D R", "B L", "D L", "B R"]
answerHashTable["drbrbldl"] = ["D R", "B R", "B L", "D L"]
answerHashTable["drbrdlbl"] = ["D R", "B R", "D L", "B L"]
answerHashTable["drdlblbr"] = ["D R", "D L", "B L", "B R"]
answerHashTable["drdlbrbl"] = ["D R", "D L", "B R", "B L"]


function getRandomSubarray(arrx, sizex) {
    var shuffled = arrx.slice(0), i = arrx.length, temp, index;
    while (i--) {
        index = Math.floor((i + 1) * Math.random());
        temp = shuffled[index];
        shuffled[index] = shuffled[i];
        shuffled[i] = temp;
    }
    return shuffled.slice(0, sizex);
}


var stimgrouplist = ['blbrdldr', 'blbrdrdl', 'bldlbrdr', 'bldldrbr', 'bldrbrdl', 'bldrdlbr', 'brbldldr', 'brbldrdl', 'brdlbldr', 'brdldrbl', 'brdrbldl', 'brdrdlbl', 'dlblbrdr', 'dlbldrbr', 'dlbrbldr', 'dlbrdrbl', 'dldrblbr', 'dldrbrbl', 'drblbrdl', 'drbldlbr', 'drbrbldl', 'drbrdlbl', 'drdlblbr', 'drdlbrbl'];
var stimgroup = getRandomSubarray(stimgrouplist, 1)[0];


define_ibex_controller({
	name: "Trial",
	jqueryWidget: {
		_init: function () {
			this.options.transfer = null; // Remove ’click to continue message’.
			this.options.hideProgressBar = true; 
			this.element.VBox({
				options: this.options,
				triggers: [1],
				children: [
					"Message", this.options,
					"QuestionFourBox", this.options,
				]
			});
		}
	},
	properties: { }
});


var defaults = [
    "AcceptabilityJudgment", { 
		presentAsScale: true, 
		hideProgressBar: true },
    "QuestionFourBox", { 
		as: answerHashTable[stimgroup], //
//		instructions: "Which sound?", 
		hasCorrect: false, 
		showNumbers: false,
		randomOrder: false, 
		presentAsScale: true, 
		timeout: 3700, 
		hideProgressBar: true },
    "Separator", { transfer: 510, normalMessage: "", errorMessage: "", hideProgressBar: true },
    "Message", { hideProgressBar: true },
    "Trial", { hideProgressBar: true},
    "Form", { hideProgressBar: true} //,

];


var shuffleSequence = seq(
	"intro", 
	//"conditionbutton",
	//"answerlist",
	"questionnaire",
	"headphones", 
	"soundcheck", 
	"instructions", 
	"instructionsSpeed", 
	"practiceIntro", 
	"practiceInstruct",
	
	"ready",
	"herewego",
	sepWith("ITI", precedeEachWith(seq("cross", "aftercross"), randomize( startsWith('pnt_')) )), 

	"practiceTimeout",
	
	"ready",
	"herewego",
	sepWith("ITI", precedeEachWith(seq("cross", "aftercross"), randomize( startsWith("pto_")) )), 
	"thatsitpractice",
	
	"noAnswer", 
	"ready",
	"herewego",

	sepWith("ITI", precedeEachWith(seq("cross", "aftercross"), randomize( startsWith('t_') )) ),
	sepWith("ITI", precedeEachWith(seq("cross", "aftercross"), randomize( startsWith('t_') )) ),
	sepWith("ITI", precedeEachWith(seq("cross", "aftercross"), randomize( startsWith('t_') )) ),
	"pause",
	sepWith("ITI", precedeEachWith(seq("cross", "aftercross"), randomize( startsWith('t_') )) ),
	sepWith("ITI", precedeEachWith(seq("cross", "aftercross"), randomize( startsWith('t_') )) ),

	"midbreak",

	sepWith("ITI", precedeEachWith(seq("cross", "aftercross"), randomize( startsWith('t_') )) ),
	sepWith("ITI", precedeEachWith(seq("cross", "aftercross"), randomize( startsWith('t_') )) ),
	sepWith("ITI", precedeEachWith(seq("cross", "aftercross"), randomize( startsWith('t_') )) ),
	"pause",
	sepWith("ITI", precedeEachWith(seq("cross", "aftercross"), randomize( startsWith('t_') )) ),
	sepWith("ITI", precedeEachWith(seq("cross", "aftercross"), randomize( startsWith('t_') )) ),

	"debrief",
	"exit2"
);




var items = [



["conditionbutton", "Separator", {transfer: "keypress", normalMessage: stimgroup, hideProgressBar: true, ignoreFailure: true}],
["answerlist", "Separator", {transfer: "keypress", normalMessage: answerHashTable[stimgroup].join(' : '), hideProgressBar: true, ignoreFailure: true}],


// Messages to subject

// Introduction to experiment - the very first screen the subject sees
["intro", "Form", {html: {include: "A_intro.html"}, checkedValue: stimgroup.concat( answerHashTable[stimgroup].join(',') ), saveReactionTime: true} ],


// A linguistic history questionnaire
["questionnaire", "Form", {html: {include: "B_questionnaire.html"}, saveReactionTime: true} ], 

["headphones", "Form", {html: {include: "C_headphones.html"}, saveReactionTime: true} ],

// Instructions
["soundcheck", "Message", {transfer: "keypress", html: {include: "D_soundcheck.html"} } ],
["instructions", "Message", {transfer: "keypress", html: {include: "E_instructions.html"} } ],
["instructionsSpeed", "Message", {transfer: "keypress", html: {include: "F_instructionsSpeed.html"} } ],

// Practice
["practiceIntro", "Message", {transfer: "keypress", html: {include: "G_practiceIntro.html"} } ],
["practiceInstruct", "Message", {transfer: "keypress", html: {include: "H_practiceInstruct.html"} } ],
["practiceTimeout", "Message", {transfer: "keypress", html: {include: "I_practiceTimeout.html"} } ],


// Tells subject that they are done with the practice items
["thatsitpractice", "Message", {transfer: "keypress", html: {include: "J_practiceDone.html"} } ],
["noAnswer", "Message", {transfer: "keypress", html: {include: "K_noAnswer.html"} } ],
["ready", "Message", {transfer: "keypress", html: {include: "_ready.html"} } ],
["herewego", "Message", {transfer: 650, html: {include: "_go.html"} } ],

["pause", "Message", {transfer: "keypress", html: {include: "_pause.html"} } ],
["midbreak", "Message", {transfer: "keypress", html: {include: "_break.html"} } ],


// debriefing
["debrief", "Form", {html: {include: "Y_debrief.html"},
                  saveReactionTime: true
                 } ], 


// Creates unique ID to paste into AMT recruitment page
["exit2", "Form", {html: { include: "Z_exit2.html" },
                   requiresConsent: true,
				   continueMessage: "Press here to conclude the experiment.",
                   saveReactionTime: true
			      } ],

["aftercross", "Separator", {transfer: 205, normalMessage: "", hideProgressBar: true, ignoreFailure: true}],
["ITI", "Separator", {transfer: 705, normalMessage: "", hideProgressBar: true, ignoreFailure: true}],
["cross", "Separator", {transfer: 505, normalMessage: "+", hideProgressBar: true, ignoreFailure: true}],


// Begin experimental items

// practice trials
// no timeout
['pnt_bd_l_1', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_01.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_01.mp3" type="audio/mpeg"> Your browser does not support the audio element. </audio>', q: "&nbsp;&nbsp;&nbsp;&nbsp;click on the sound", hasCorrect: false, timeout: null, hideProgressBar: true}, "Separator", 150, "Message", {html: "<div style='text-align: center;'> answer: </div><div style='text-align: center; font-size: 150%; margin-top: 12pt;'> B L </div>", transfer: 1900}],
['pnt_bd_l_17', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_17.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_17.mp3" type="audio/mpeg"> Your browser does not support the audio element. </audio>', q: "&nbsp;&nbsp;&nbsp;&nbsp;click on the sound", hasCorrect: false, timeout: null, hideProgressBar: true}, "Separator", 150, "Message", {html: "<div style='text-align: center;'> answer: </div><div style='text-align: center; font-size: 150%; margin-top: 12pt;'> D L </div>", transfer: 1900}],
['pnt_bd_r_1', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_01.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_01.mp3" type="audio/mpeg"> Your browser does not support the audio element. </audio>', q: "&nbsp;&nbsp;&nbsp;&nbsp;click on the sound", hasCorrect: false, timeout: null, hideProgressBar: true}, "Separator", 150, "Message", {html: "<div style='text-align: center;'> answer: </div><div style='text-align: center; font-size: 150%; margin-top: 12pt;'> B R </div>", transfer: 1900}],
['pnt_bd_r_17', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_17.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_17.mp3" type="audio/mpeg"> Your browser does not support the audio element. </audio>', q: "&nbsp;&nbsp;&nbsp;&nbsp;click on the sound", hasCorrect: false, timeout: null, hideProgressBar: true}, "Separator", 150, "Message", {html: "<div style='text-align: center;'> answer: </div><div style='text-align: center; font-size: 150%; margin-top: 12pt;'> D R </div>", transfer: 1900}],


// practice trials
// with timeouts
['pto_bd_l_1', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_01.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_01.mp3" type="audio/mpeg"> Your browser does not support the audio element. </audio>', q: "&nbsp;&nbsp;&nbsp;&nbsp;click on the sound", hasCorrect: false, timeout: 4000, hideProgressBar: true}, "Separator", 130, "Message", {html: "<div style='text-align: center;'> answer: </div><div style='text-align: center; font-size: 150%; margin-top: 12pt;'> B L </div>", transfer: 1500}],
['pto_bd_l_17', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_17.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_17.mp3" type="audio/mpeg"> Your browser does not support the audio element. </audio>', q: "&nbsp;&nbsp;&nbsp;&nbsp;click on the sound", hasCorrect: false, timeout: 4000, hideProgressBar: true}, "Separator", 130, "Message", {html: "<div style='text-align: center;'> answer: </div><div style='text-align: center; font-size: 150%; margin-top: 12pt;'> D L </div>", transfer: 1500}],
['pto_bd_r_1', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_01.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_01.mp3" type="audio/mpeg"> Your browser does not support the audio element. </audio>', q: "&nbsp;&nbsp;&nbsp;&nbsp;click on the sound", hasCorrect: false, timeout: 4000, hideProgressBar: true}, "Separator", 130, "Message", {html: "<div style='text-align: center;'> answer: </div><div style='text-align: center; font-size: 150%; margin-top: 12pt;'> B R </div>", transfer: 1500}],
['pto_bd_r_17', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_17.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_17.mp3" type="audio/mpeg"> Your browser does not support the audio element. </audio>', q: "&nbsp;&nbsp;&nbsp;&nbsp;click on the sound", hasCorrect: false, timeout: 4000, hideProgressBar: true}, "Separator", 130, "Message", {html: "<div style='text-align: center;'> answer: </div><div style='text-align: center; font-size: 150%; margin-top: 12pt;'> D R </div>", transfer: 1500}],


// test trials
['t_bd_l_1', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_01.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_01.mp3" type="audio/mpeg"> Your browser does not support the audio element.</audio>', hideProgressBar: true}],
['t_bd_l_4', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_04.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_04.mp3" type="audio/mpeg"> Your browser does not support the audio element.</audio>', hideProgressBar: true}],
['t_bd_l_6', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_06.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_06.mp3" type="audio/mpeg"> Your browser does not support the audio element.</audio>', hideProgressBar: true}],
['t_bd_l_7', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_07.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_07.mp3" type="audio/mpeg"> Your browser does not support the audio element.</audio>', hideProgressBar: true}],
['t_bd_l_8', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_08.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_08.mp3" type="audio/mpeg"> Your browser does not support the audio element.</audio>', hideProgressBar: true}],
['t_bd_l_10', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_10.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_10.mp3" type="audio/mpeg"> Your browser does not support the audio element.</audio>', hideProgressBar: true}],
['t_bd_l_14', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_14.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_14.mp3" type="audio/mpeg"> Your browser does not support the audio element.</audio>', hideProgressBar: true}],
['t_bd_l_17', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_17.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdlaa_17.mp3" type="audio/mpeg"> Your browser does not support the audio element.</audio>', hideProgressBar: true}],
['t_bd_r_1', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_01.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_01.mp3" type="audio/mpeg"> Your browser does not support the audio element.</audio>', hideProgressBar: true}],
['t_bd_r_4', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_04.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_04.mp3" type="audio/mpeg"> Your browser does not support the audio element.</audio>', hideProgressBar: true}],
['t_bd_r_6', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_06.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_06.mp3" type="audio/mpeg"> Your browser does not support the audio element.</audio>', hideProgressBar: true}],
['t_bd_r_7', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_07.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_07.mp3" type="audio/mpeg"> Your browser does not support the audio element.</audio>', hideProgressBar: true}],
['t_bd_r_8', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_08.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_08.mp3" type="audio/mpeg"> Your browser does not support the audio element.</audio>', hideProgressBar: true}],
['t_bd_r_10', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_10.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_10.mp3" type="audio/mpeg"> Your browser does not support the audio element.</audio>', hideProgressBar: true}],
['t_bd_r_14', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_14.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_14.mp3" type="audio/mpeg"> Your browser does not support the audio element.</audio>', hideProgressBar: true}],
['t_bd_r_17', "Trial", {html: '<audio autoplay="autoplay"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_17.wav" type="audio/wav"> <source src="https://udrive.oit.umass.edu/kmullin/_exp/bdraa_17.mp3" type="audio/mpeg"> Your browser does not support the audio element.</audio>', hideProgressBar: true}],



[["itdoesntmatchanything", 124], "Trial", {s: ""}] 
// Be sure there's no comma after the LAST ITEM !!

];

