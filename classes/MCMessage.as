package  classes
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Anthony P. Alaan
	 */
	public class MCMessage extends MovieClip
	{
		
		public function MCMessage(s:String) 
		{
			txtmessage.text = s;
			this.btnok.addEventListener(MouseEvent.CLICK, function():void {
				if (onOK != null) onOK.apply();
			});
		}
		private var onOK:Function;
		public function setOnOK(f:Function):void {
			this.onOK = f;
		}
		
	}

}