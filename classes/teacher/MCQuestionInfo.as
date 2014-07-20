package classes.teacher 
{
	import fl.controls.RadioButton;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import fl.controls.ComboBox;
	import fl.controls.DataGrid;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import classes.functions.Connect;
	import classes.functions.Functions;
	import flash.events.Event;
	import classes.Static;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import classes.ExecuteFunctionAfter;
	/**
	 * ...
	 * @author Anthony P. Alaan
	 */
	public class MCQuestionInfo extends MovieClip 
	{
		
		public function MCQuestionInfo(question:String = "", question_type:String = "multiple choice", points:int = 1, 
		choices:Array=null, correct:Array=null) 
		{
			Functions.setButtonEvents([_btnok, _btncancel]);
			this._lblidentification.visible = this._txtidentification.visible = false;
			this._cmbquestiontype.addEventListener(Event.CHANGE, function():void {
				var m:Array = [_txta, _txtb, _txtc, _txtd, _rbtna, _rbtnb, rbtnc, rbtnd];
				var i:Array = [_lblidentification, _txtidentification];
				if (questiontype == "multiple choice") {
					for each (var item:DisplayObject in m) 
					{
						item.visible = true;
					}
					for each (var item:DisplayObject in i) 
					{
						item.visible = false;
					}
				}else {
					for each (var item:DisplayObject in m) 
					{
						item.visible = false;
					}
					for each (var item:DisplayObject in i) 
					{
						item.visible = true;
					}
				}
			});
			this.question = question;
			this.question_type = question_type;
			this.choices = choices;
			this.correct = correct;
			this.points = points;
			this._txtquestion.text = this.question;
			this.questiontype = this.question_type;	
			if (this.choices != null && this.questiontype == "multiple choice") {
				_txta.text = choices[0];
				_txtb.text = choices[1];
				_txtc.text = choices[2];
				_txtd.text = choices[3];
			}
			else if (this.choices != null && this.questiontype == "identification") {
				_txtidentification.text = this.choices[0];
			}
			this.addEventListener(Event.ADDED_TO_STAGE, added);
			this._btnok.addEventListener(MouseEvent.CLICK, function():void {
				
				if (checkInputs() && _onOK != null) _onOK.apply();
			});
			this._btncancel.addEventListener(MouseEvent.CLICK, function():void {
				if (_onCancel != null) _onCancel.apply();
			});
			new ExecuteFunctionAfter(function():void {
				if (correct != null && questiontype == "multiple choice") {
				if (correct[0] == "true") _rbtna.selected = true;
				else if (correct[1] == "true") _rbtnb.selected = true;
				else if (correct[2] == "true") _rbtnc.selected = true;
				else if (correct[3] == "true") _rbtnd.selected = true;
			}
			}, [], this, 0.2).start();
		}
		private function added(e:Event):void {
			
		}
		private function checkInputs():Boolean {
			var ok:Boolean = false;
				if (questiontype == "multiple choice") {
					if (isAllHasAnswer()) {
						if (hasDefaultAnswer()) {
							if (_txtquestion.text.replace(" ", "") != "") {
								if (_txtpoints.text.replace() != "") {
									ok = true;
								}else {
									Static.it8.showMessage("Please enter points.");
								}
							}else {
								Static.it8.showMessage("Please enter question.");
							}
						}else {
							Static.it8.showMessage("Please select a default answer.");
						}
					}else {
						Static.it8.showMessage("Please fill all the choices.");
					}
				}else {
					if (_txtidentification.text.replace(" ","" ) != "") {
							if (_txtquestion.text.replace(" ", "") != "") {
								if (_txtpoints.text.replace() != "") {
									ok = true;
								}else {
									Static.it8.showMessage("Please enter points.");
								}
							}else {
								Static.it8.showMessage("Please enter question.");
							}
					}else {
						Static.it8.showMessage("Please enter answer.");
					}
				}
			
			return ok;
		}
		public function set questiontype(value:String):void 
		{
			if (value == "multiple choice") this._cmbquestiontype.selectedIndex = 0;
			else this._cmbquestiontype.selectedIndex = 1;
		}
		public function get questiontype():String { if (this._cmbquestiontype.selectedIndex == 0) return "multiple choice";
		else return "identification"; }
		public function set points(value:int):void 
		{
			this._txtpoints.text = "" + value;
		}
		public function get points():int { return int(this._txtpoints.text); }
		public function get question_():String { return this._txtquestion.text; }
		public function get choices_():Array { 
			var c:Array = new Array();
			if (this.questiontype == "multiple choice") {
				c.push(_txta.text);
				c.push(_txtb.text);
				c.push(_txtc.text);
				c.push(_txtd.text);
			}else {
				c.push(_txtidentification.text);
			}
			return c;
		}
		public function get correct_():Array {
			var c:Array = new Array();
			if (this.questiontype == "multiple choice") {
				c.push(_rbtna.selected.toString());
				c.push(_rbtnb.selected.toString());
				c.push(_rbtnc.selected.toString());
				c.push(_rbtnd.selected.toString());
			}else {
				c.push("true");
			}
			return c;
		}
		public function set onOK(value:Function):void 
		{
			this._onOK = value;
		}
		public function set onCancel(value:Function):void 
		{
			this._onCancel = value;
		}
		private function hasDefaultAnswer():Boolean {
			var has:Boolean = false;
			var m:Array = [ _rbtna, _rbtnb, rbtnc, rbtnd];
			for each (var item:RadioButton in m) 
			{
				if (item.selected) has = true;
			}
			return has;
		}
		private function isAllHasAnswer():Boolean {
			var m:Array = [_txta, _txtb, _txtc, _txtd];
			var has:Boolean = true;
			for each (var item:TextField in m) 
			{
				if (item.text.replace(" ", "") == "") {
					has = false;
				}
			}
			return has;
		}
		
		
		private var question:String, question_type:String, choices:Array, correct:Array, _onOK:Function, _onCancel:Function;
		
		public function get _txtquestion():TextField { return this.txtquestion; }
		public function get _cmbquestiontype():ComboBox { return this.cmbquestiontype; }
		public function get _lblidentification():TextField { return this.lblidentification; }
		public function get _txtidentification():TextField { return this.txtidentification; }
		public function get _rbtna():RadioButton { return this.rbtna; }
		public function get _rbtnb():RadioButton { return this.rbtnb; }
		public function get _rbtnc():RadioButton { return this.rbtnc; }
		public function get _rbtnd():RadioButton { return this.rbtnd; }
		public function get _txta():TextField { return this.txta; }
		public function get _txtb():TextField { return this.txtb; }
		public function get _txtc():TextField { return this.txtc; }
		public function get _txtd():TextField { return this.txtd; }
		public function get _txtpoints():TextField { return this.txtpoints; }
		public function get _btnok():SimpleButton { return this.btnok; }
		public function get _btncancel():SimpleButton { return this.btncancel; }
		
	}

}