package classes
{
	import classes.functions.Functions;
	import flash.display.MovieClip;
	import com.greensock.data.TweenLiteVars;
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import flash.events.Event;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import classes.MCConfirm;
	
	/**
	 * ...
	 * @author Anthony P. Alaan
	 */
	public class IT8 extends MovieClip 
	{
		
		public function IT8() 
		{
			Static.it8 = this;
			Static.loadSettings();
			this.addEventListener(Event.ADDED_TO_STAGE, added);
			this.mc_modal.visible = false;
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			stage.scaleMode = StageScaleMode.SHOW_ALL;
		}
		private function added(e:Event):void {
			txtloading.x = 0 - txtloading.width;
			TweenLite.to(txtloading, 1, new TweenLiteVars().x(1366 / 2 - txtloading.width / 2).ease(Linear.easeNone));
			var interval:uint = setInterval(function():void {
				clearInterval(interval);
				TweenLite.to(Static.it8.txtloading, 1, new TweenLiteVars().x(0 - Static.it8.txtloading.width).ease(Linear.easeNone) );
			}, 3000);
		}
		public function get modalmc():MovieClip { return mc_modal; }
		public function showMessage(s:String,onClose:Function=null):void {
			var messagemc:MCMessage = new MCMessage(s);
			messagemc.setOnOK(function():void {
				messagemc.visible = false;
				removeChild(messagemc);
				modalmc.visible = false;
				if (onClose != null) onClose.apply();
			});
			this.modalmc.visible = true;
			addChild(messagemc);
			Functions.centerToStage(messagemc);
		}
		public function showConfirm(s:String, onYes:Function):void{
			var confirmmc:MCConfirm = new MCConfirm(s);
			confirmmc.setOnYes(onYes);
			confirmmc.setOnClose(function():void {
				confirmmc.visible = false;
				removeChild(confirmmc);
				modalmc.visible = false;
			});
			modalmc.visible = true;
			addChild(confirmmc);
			Functions.centerToStage(confirmmc);
			 
		}
	}
}