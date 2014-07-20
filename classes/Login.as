package  classes
{
	import com.greensock.TimelineLite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import classes.functions.Connect;
	import flash.net.URLVariables;
	import com.greensock.TweenLite;
	import com.greensock.data.TweenLiteVars;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.easing.Linear;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	/**
	 * ...
	 * @author Anthony P. Alaan
	 */
	public class Login extends MovieClip 
	{
		
		public function Login() 
		{
			TweenPlugin.activate([AutoAlphaPlugin]);
			this.y = 0 - this.height;
			this.addEventListener(Event.ADDED_TO_STAGE, added);
			txterror.visible = false;
			txtregister.addEventListener(MouseEvent.ROLL_OVER, function():void {
				txtregister.textColor = 0x0080FF;
				Mouse.cursor = MouseCursor.BUTTON;
			});
			txtregister.addEventListener(MouseEvent.ROLL_OUT, function():void {
				txtregister.textColor = 0xFFFFFF;
				Mouse.cursor = MouseCursor.AUTO;
			});
			txtregister.addEventListener(MouseEvent.CLICK, function():void {
				exit("register");
			});
		}
		private function added(e:Event):void {
			TweenLite.to(this, 1, new TweenLiteVars().ease(Linear.easeNone).y(768 / 2 - this.height / 2));
			this.btnlogin.addEventListener(MouseEvent.CLICK, function():void {
				var vars:URLVariables = new URLVariables();
				vars.requestName = "isAccountExist";
				vars.user_name = txtusername.text;
				vars.user_pass = txtpassword.text;
				Connect.request(vars, function(e:Event):void {
					if (e.target.data.exist == "true") {
						Static.user_name = txtusername.text;
						Static.user_type = e.target.data.user_type;
						Static.user_id = e.target.data.user_id;
						showError("Access accepted.");
						if (Static.user_type == "student") {
							exit("main_student");
						}else if (Static.user_type == "teacher") {
							exit("main_teacher");
						}
					}else {
						Static.it8.showMessage("Invalid username or password.");
					}
				});
			});
		}
		private function login():void {
			if (this.checkInputs()) {
				
			}
		}
		private function checkInputs():Boolean {
			var ok:Boolean = true;
			if (txtusername.text.replace(" ","") == "") {
				ok = false; Static.it8.showMessage("Please enter username");
			}else if (txtpassword.text == "") {
				ok = false; Static.it8.showMessage("Please enter password.");
			}
			return ok;
		}
		
		private function showError(s:String):void {
			txterror.visible = true;
			txterror.text = s;
		}
		private function exit(goto:String):void {
			TweenLite.to(this, 1, new TweenLiteVars().y(0 - this.height).ease(Linear.easeNone).onComplete(function():void {
				Static.goto(goto);
			}));
		}
	}

}