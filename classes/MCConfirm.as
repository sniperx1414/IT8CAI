package classes
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Anthony P. Alaan
	 */
	public class MCConfirm extends MovieClip 
	{
		
		public function MCConfirm(message:String) 
		{
			txtmessage.text = message;
			this.btnyes.addEventListener(MouseEvent.CLICK, function():void {
				if (onYes != null) onYes.apply();
				if (onClose != null) onClose.apply();
			});
			this.btnno.addEventListener(MouseEvent.CLICK, function():void {
				if (onNo != null) onNo.apply();
				if (onClose != null) onClose.apply();
			});
		}
		private var onYes:Function;
		private var onNo:Function, onClose:Function;
		public function setOnYes(onYes:Function):void {
			this.onYes = onYes;
		}
		public function setOnNo(onNo:Function):void {
			this.onNo = onNo;
		}
		public function setOnClose(f:Function):void {
			this.onClose = f;
		}
		
	}

}