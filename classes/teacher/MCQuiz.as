package classes.teacher 
{
	import adobe.utils.CustomActions;
	import fl.controls.ComboBox;
	import fl.controls.DataGrid;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import classes.functions.Connect;
	import classes.functions.Functions;
	import flash.events.Event;
	import classes.Static;
	import flash.events.MouseEvent;
	import classes.Mode;
	import classes.IT8;
	import flash.net.URLVariables;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Anthony P. Alaan
	 */
	public class MCQuiz extends MovieClip 
	{
		
		
		public function MCQuiz(mode:int=0,quiz_id:String="") 
		{
			this.mode = mode;
			this.quiz_id = quiz_id;
			this.setSettings();
			Functions.setButtonEvents([_btnclose, _btndelete, _btnnew, _btnedit,_btnsave]);
			this.setEvents();
			this.idstodelete = new Array();
		}
		private var mode:int, quiz_id:String, _onClose:Function;
		private var questioninfo:MCQuestionInfo;
		private var questions:Array;
		private var idstodelete:Array;
		//[question_id,question, question_type,points, [choice_id],[choice],[correct] ]
		private function setSettings():void {
			if (this.mode == Mode.NEW) {
				this.questions = new Array();
			}else if (this.mode == Mode.EDIT) {
				this.setQuestions();
			}else {
				
			}
			this.updateQuestions();
		}
		private function setQuestions():void {
			this.questions = new Array();
			var vars:URLVariables = new URLVariables();
			vars.requestName = "getQuizQuestions";
			vars.quiz_id = this.quiz_id;
			var oncomplete:Function = function(e:Event):void {
				var choice_id:Array, question_id:Array, question:Array, question_type:Array, points:Array, choice:Array, correct:Array;
				choice_id = Functions.getRecords(e.target.data.choice_id);
				question_id = Functions.getRecords(e.target.data.question_id);
				question = Functions.getRecords(e.target.data.question);
				question_type = Functions.getRecords(e.target.data.question_type);
				points = Functions.getRecords(e.target.data.points);
				choice = Functions.getRecords(e.target.data.choice);
				correct = Functions.getRecords(e.target.data.correct);
				
				var temp_choice_id:Array, temp_choice:Array, temp_correct:Array;
				var q:Array = new Array();
				var temp_question_id:String = "";
				for (var i:int = 0; i < choice_id.length; i++) 
				{
					temp_question_id = question_id[i];
					if (i == 0 || question_id[i - 1] != temp_question_id) {
						q = new Array();
						q = [null, null, null, null, [], [], []];
						questions.push(q);
						q[0] = question_id[i];
						q[1] = question[i];
						q[2] = question_type[i];
						q[3] = points[i];
						temp_choice_id = q[4];
						temp_choice = q[5];
						temp_correct = q[6];
					}
					temp_choice_id.push(choice_id[i]);
					temp_choice.push(choice[i]);
					temp_correct.push(correct[i]);
				}
				updateQuestions();
			};
			Connect.request(vars, oncomplete);
		}
		private function setEvents() {
			this._btnclose.addEventListener(MouseEvent.CLICK, function():void {
				if (_onClose != null) _onClose.apply();
			});
			this._btnnew.addEventListener(MouseEvent.CLICK, function():void {
				questioninfo = new MCQuestionInfo();
				showQuestionInfo(questioninfo);
				questioninfo.onCancel = function():void {
					Functions.outro(questioninfo, 0.5, function(tar:DisplayObject):void {
						removeChild(tar);
					},[questioninfo]);
				};
				questioninfo.onOK = function():void {
					addNewQuestion("",questioninfo.question_, questioninfo.questiontype, questioninfo.points, questioninfo.choices_, 
					questioninfo.correct_);
					Functions.outro(questioninfo, 0.5, function(tar:DisplayObject):void {
						removeChild(tar);
					},[questioninfo]);
				};
			});
			this._btndelete.addEventListener(MouseEvent.CLICK, function():void {
				if (_tablequestions.selectedIndex != -1) {
					Static.it8.showConfirm("Confirm delete question?", function():void {
						if (String(_tablequestions.selectedItem["Question ID"]) != "") {
							idstodelete.push(_tablequestions.selectedItem["Question ID"] as String);
						}
						questions.splice(_tablequestions.selectedIndex, 1);
						updateQuestions();
					});
				}else {
					Static.it8.showMessage("Please select a question to delete.");
				}
			});
			this._btnedit.addEventListener(MouseEvent.CLICK , function():void {
				if (_tablequestions.selectedIndex != -1) {
					var i:int = _tablequestions.selectedIndex;
					var q:Array = questions[i];
					questioninfo = new MCQuestionInfo(
					q[1], q[2], q[3], q[5], q[6] );
					showQuestionInfo(questioninfo);
					questioninfo._cmbquestiontype.enabled = false;
					questioninfo.onCancel = function():void {
						Functions.outro(questioninfo, 0.5, function(tar:DisplayObject):void {
							DisplayObject(tar).parent.removeChild(tar);
						},[questioninfo]);
					};
					questioninfo.onOK = function():void {
						updateQuestion(i, q[0], questioninfo.question_, questioninfo.questiontype, questioninfo.points, q[4], questioninfo.choices_,
						questioninfo.correct_);
						Functions.outro(questioninfo, 0.5, function(tar:DisplayObject):void {
							removeChild(tar);
						},[questioninfo]);
					};
				}else {
					Static.it8.showMessage("Please select a question to edit.");
				}
			});
			this._btnsave.addEventListener(MouseEvent.CLICK, function():void {
				if (_txtquizdescription.text.replace(" ", "") != "") {
					if (_txttimelimit.text.replace(" ", "")  != "") {
						if (questions.length != 0) {
							Static.it8.showConfirm("Confirm save?", function():void {
								save();
							});
						}else {
							Static.it8.showMessage("Please add questions.");
						}
					}else {
						Static.it8.showMessage("Please enter time limit.");
					}
				}else {
					Static.it8.showMessage("Please enter quiz description.");
				}
			});
		}
		private function save():void {
			var oncomplete:Function = function(e:Event):void {
				quiz_id = e.target.data.quiz_id;
				var vars:URLVariables = new URLVariables();
				var q:Array;
				for (var i:int = 0; i < questions.length; i++) 
				{
					q = questions[i];
					vars.requestName = "saveQuestion";
					vars.quiz_id = quiz_id;
					vars.question_id = q[0];
					vars.question = q[1];
					vars.points = q[3];
					vars.question_type = q[2];
					vars.choice_id = Functions.getArrayToString(q[4] as Array);
					vars.choice = Functions.getArrayToString(q[5] as Array);
					vars.correct = Functions.getArrayToString(q[6] as Array);
					Connect.request(vars, function(e1:Event):void {
						
					});
				}
				var commands:Array = new Array();
				for each (var item:String in idstodelete) 
				{
					commands.push("delete from quiz_questions where question_id = '"+item+"';");
				}
				Connect.executeCommands(commands, function(e1):void {
					
				});
				if (_onClose != null) {
					_onClose.apply();
				}
			};
			var vars:URLVariables = new URLVariables();
			if (this.mode == Mode.NEW) {
				vars.requestName = "addNewQuiz";
				vars.teacher_id = Static.user_id;
				vars.timelimit = _txttimelimit.text;
				vars.quiz_desc = _txtquizdescription.text;
				Connect.request(vars, oncomplete);
			}else {
				vars.requestName = "updateQuiz";
				vars.quiz_id = quiz_id;
				vars.quiz_desc = _txtquizdescription.text;
				vars.timelimit = _txttimelimit.text;
				Connect.request(vars, oncomplete);
			}
		}
		
		private function showQuestionInfo(questioninfo:MCQuestionInfo):void {
			addChild(questioninfo);
			questioninfo.x = width / 2 - questioninfo.width / 2 ;
			questioninfo.y = height / 2 - questioninfo.height / 2;
			Functions.intro(questioninfo);
		}
		public function set onclose(value):void 
		{
			this._onClose = value;
		}
		private function addNewQuestion(question_id:String,question:String,question_type:String, points:int, choices:Array, correct:Array):void {
			this.questions.push([question_id, question, question_type, points,[], choices, correct]);
			this.updateQuestions();
		}
		private function updateQuestion(index:int, question_id:String, question:String, question_type:String, points:int, choice_id:Array,
			choices:Array, correct:Array):void {
			this.questions[index] = [question_id, question, question_type, points, choice_id, choices, correct];
			this.updateQuestions();
		}
		private function updateQuestions():void {
			this._tablequestions.columns = ["Question ID", "Question", "Type", "Points"];
			Functions.hideColumn(this._tablequestions, 0);
			var newrow:Object;
			this._tablequestions.removeAll();
			for (var i:int = 0; i < this.questions.length; i++) 
			{
				newrow = new Object();
				newrow["Question ID"] = this.questions[i][0];
				newrow["Question"] = this.questions[i][1];
				newrow["Type"] = this.questions[i][2];
				newrow["Points"] = this.questions[i][3];
				this._tablequestions.addItem(newrow);
			}
			
		}	
		
		public function get _tablequestions():DataGrid { return this.tablequestions; }
		public function get _btnnew():SimpleButton { return this.btnnew; }
		public function get _btnedit():SimpleButton { return this.btnedit; }
		public function get _btndelete():SimpleButton { return this.btndelete; }
		public function get _btnclose():SimpleButton { return this.btnclose; }
		public function get _btnsave():SimpleButton { return this.btnsave; }
		public function get _txtquizdescription():TextField { return this.txtquizdescription; }
		public function get _txttimelimit():TextField { return this.txttimelimit; }
	}
	

}