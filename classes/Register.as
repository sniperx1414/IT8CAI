package  classes
{
	
	import fl.controls.ComboBox;
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.greensock.data.TweenLiteVars;
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import flash.events.MouseEvent;
	import flash.net.URLVariables;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	import flash.display.MovieClip;
	import classes.functions.Connect;
	import classes.functions.Functions;
	
	/**
	 * ...
	 * @author Anthony P. Alaan
	 */
	public class Register extends MovieClip 
	{
		
		public function Register() 
		{
			this.x = 0 - this.width;
			this.addEventListener(Event.ADDED_TO_STAGE, added);
			txterror.visible = false;
			this.btnok.addEventListener(MouseEvent.CLICK, function():void {
				save();
			});
			this.btncancel.addEventListener(MouseEvent.CLICK, function():void {
				exit("login");
			});
		}
		private var section_teacher_id:Array, sec_name:Array;
		private function added(e:Event):void {
			this.intro();
			this.setSections();
		}
		private function intro():void {
			this.x = 0 - this.width;
			TweenLite.to(this,1, new TweenLiteVars().x(1366 / 2 - this.width / 2).ease(Linear.easeNone));
		}
		private function exit(goto:String):void {
			TweenLite.to(this, 1, new TweenLiteVars().y(0 - this.height).ease(Linear.easeNone).onComplete(function():void {
				Static.goto(goto);
			}));
		}
		private function checkInputs():Boolean {
			var ok:Boolean = true;
			if (txtfn.text.replace(" ", "") == "") {
				ok = false; showError("Please enter first name.");
			}else if (txtln.text.replace(" ", "") == "") {
				ok = false; showError("Please enter last name.");
			}else if (ComboBox(cmbsections).selectedIndex == -1) {
				ok = false; showError("Please select section.");
			}else if (txtusername.text.replace(" ", "") == "") {
				ok = false; showError("Please enter username.");
			}else if (txtpassword.text == "") {
				ok = false; showError("Please enter password.");
			}else if (txtconfirmpassword.text == "") {
				ok = false; showError("Please confirm password.");
			}else if (txtpassword.text != txtconfirmpassword.text) {
				ok = false; showError("Passwords did not match.");
			}else if (txtpassword.text.length < 6) {
				ok = false; Static.it8.showMessage("Password must be more than 5 characters.");
			}
			return ok;
		}
		private function setSections():void {
			Connect.search("select section_teacher_id, sec_name from section_teacher st left join sections s on " +
				"s.sec_id = st.sec_id where st.active = true;", 
				["section_teacher_id", "sec_name"], 
				function(e:Event):void {
				section_teacher_id = Functions.getRecords(e.target.data.section_teacher_id);
				sec_name = Functions.getRecords(e.target.data.sec_name);
				Functions.setComboBox(cmbsections,sec_name);
			});
		}
		private function get SelectedSectionteacherID():String { return this.section_teacher_id[ComboBox(cmbsections).selectedIndex]; }
		private function save():void {
			if (this.checkInputs()) {
				Connect.search(Functions.getFormatString("select stud_id from students where stud_fn = '" + txtfn.text
				+"' and stud_mn = '" + txtmn.text + "' and stud_ln = '" + txtln.text + "';"), 
				["stud_id"], function(e:Event):void {
					if (Functions.getRecords(e.target.data.stud_id).length == 0) {
						var vars:URLVariables = new URLVariables();
						vars.requestName = "isUsernameExist";
						vars.user_name = txtusername.text;
						
						Connect.request(vars, function(e1:Event):void {
							if (e1.target.data.exist == "false") {
								Static.it8.showConfirm("Confirm registration?", function():void {
									vars = new URLVariables();
									vars.requestName = "register";
									vars.fn = Functions.getFormatString(txtfn.text);
									vars.mn = Functions.getFormatString(txtmn.text);
									vars.ln = Functions.getFormatString(txtln.text);
									vars.user_name = Functions.getFormatString(txtusername.text);
									vars.user_pass = Functions.getFormatString(txtpassword.text);
									vars.section_teacher_id = SelectedSectionteacherID;
									Connect.request(vars, function(e2):void {
										if (e2.target.data.success == "true") {
											Static.it8.showMessage("Registration is successful.", function():void {
												exit("login");
											});
										}
									});
								});
							}else {
								Static.it8.showMessage("Username already exist.");
							}
						});
					}else {
						Static.it8.showMessage("Can't continue registration. Name already registered.");
					}
				});
			}
		}
		private function showError(s:String):void {
			txterror.text = s;
			txterror.visible = true;
		}
	}

}