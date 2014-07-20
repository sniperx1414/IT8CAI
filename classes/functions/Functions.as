package  classes.functions
{
	import com.greensock.data.TweenLiteVars;
	import com.greensock.loading.data.SWFLoaderVars;
	import com.greensock.loading.LoaderMax;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.TimelineLite;
	import fl.controls.CheckBox;
	import fl.controls.RadioButton;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import com.greensock.loading.SWFLoader;
	import flash.display.SimpleButton;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.events.Event;
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.AutoAlphaPlugin;
	import fl.controls.ComboBox;
	import fl.controls.List;
	import fl.controls.DataGrid;
	import fl.controls.Button;
	import fl.data.DataProvider;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.net.navigateToURL;
	import flash.utils.ByteArray;
	import com.greensock.plugins.ScalePlugin;
	/**
	 * ...
	 * @author Anthony P. Alaan
	 */
	public class Functions 
	{
		
		public function Functions() 
		{
			
		}
		
		public var mc_background:MovieClip;
		private static var swfloader:LoaderMax;
		public static var MONTHS:Array = ['January', 'February', 'March', "April", "May", "June", "July", "August", "September"
							,"October", "November", "December"];
		public static var letters:String = "abcdefghijklmnopqrstuvwxyz";
		
		
		public static function getData(e:Event, name:String):String {
			return e.target.data[name];
		}
		public static function isChild(child:DisplayObject, container:MovieClip):Boolean {
			var ch:Boolean = false;
			ch = container.getChildIndex(child) != -1;
			return ch;
		}
		public static function centerToStage(mc:DisplayObject) {
			mc.x = 1366 / 2 - mc.width / 2;
			mc.y = 768 / 2 - mc.height / 2;
		}
		
		
		public static function setDataGrid(table:DataGrid,tableData:Array,cols:Array):void{
			table.removeAll();
			var temp:Array;
			table.columns = cols;
			var ob:Object;
			for (var i:int = 0; i < tableData[0].length; i++ ) {
				ob = new Object();
				for (var j:int = 0; j <  cols.length; j ++ ) {
					ob[cols[j]] = tableData[j][i];
				}
				table.addItem(ob);
			}
		}
		public static function getGlobalTextFormat():TextFormat {
			var txtformat:TextFormat = new TextFormat();
			txtformat.font = "Andalus";
			txtformat.size = 20;
			return txtformat;
		}
		public static function formatCombobox(cmb:ComboBox):void {
			cmb.textField.setStyle("textFormat", getGlobalTextFormat());
			cmb.dropdown.setRendererStyle("textFormat", getGlobalTextFormat());
			cmb.dropdown.rowHeight = 25;
			cmb.validateNow();
		}
		public static function formatDatagrid(table:DataGrid):void {
			table.setRendererStyle("textFormat", getGlobalTextFormat());
			var textformat:TextFormat = new TextFormat();
			textformat.bold = true;
			textformat.size = 15;
			table.setStyle("headerTextFormat", textformat);
			table.headerHeight = 30;
			table.validateNow();
		}
		public static function formatButton(btn:Button):void {
			btn.setStyle("textFormat",getGlobalTextFormat());
			btn.validateNow();
		}
		public static function formatList(list:List):void {
			list.setRendererStyle("textFormat", getGlobalTextFormat());
		}
		public static function formatRadioButton(radio:RadioButton):void {
			radio.setStyle("textFormat", getGlobalTextFormat());
			radio.validateNow();
		}
		public static function formatCheckBox(chk:CheckBox) {
			chk.setStyle("textFormat", getGlobalTextFormat());
			chk.textField.autoSize = TextFieldAutoSize.RIGHT;
			chk.validateNow();
		}
		public static function formatAllComponentChild(mc:MovieClip,except:Array=null):void {
			for (var i:int = 0; i < mc.numChildren; i++) 
			{
				if (except != null && except.indexOf(mc.getChildAt(i)) != -1) {
					
				}
				else if (mc.getChildAt(i) is ComboBox) {
					trace(mc.getChildAt(i).name);
					formatCombobox(ComboBox(mc.getChildAt(i)));
				}else if (mc.getChildAt(i) is List) {
					formatList(List(mc.getChildAt(i)));
				}else if (mc.getChildAt(i) is DataGrid) {
					formatDatagrid(DataGrid(mc.getChildAt(i)));
				}else if (mc.getChildAt(i) is Button) {
					formatButton(Button(mc.getChildAt(i)));
				}else if (mc.getChildAt(i) is CheckBox) {
					formatCheckBox(mc.getChildAt(i) as CheckBox);
				}else if (mc.getChildAt(i) is RadioButton) {
					formatRadioButton(mc.getChildAt(i) as RadioButton);
				}
			}
		}
		
		public static function setComboBox(cmb:ComboBox, data:Array):void {
			cmb.removeAll();
			//var data1:DataProvider = new DataProvider();
			//for (var i:int = 0; i < data.length; i++ ) {
				//data1.addItem( { label: data[i], data: data[i] } );
			//}
			//cmb.dataProvider = data1;
			for (var i:int = 0; i < data.length; i++) 
			{
				cmb.addItem({label: data[i], data: data[i]});
			}
		}
		public static function setList(list:List, data:Array):void {
			list.removeAll();
			var provider:DataProvider = new DataProvider();
			for (var i:int = 0; i < data.length; i++) 
			{
				provider.addItem({label: data[i], data: data[i]});
			}
			list.dataProvider = provider;
		}
		public static function setComboMonth(cmb:ComboBox):void {
			cmb.removeAll();
			for (var i:int = 0; i < MONTHS.length; i++ ) {
				cmb.addItem({label: MONTHS[i], data: i+1});
			}
		}
		
		public static function trim(s:String):String {
			var temp:String = "";
			for (var i:int = 0; i < s.length; i++) 
			{
				if (s.charAt(i) != " ") {
					temp += s.charAt(i);
				}
			}
			return temp;
		}
		
		public static function setComboDay(cmb:ComboBox):void {
			var arr:Array = new Array();
			for (var i:int = 0; i < 31; i++) 
			{
				arr.push(""+(i + 1));
			}
			Functions.setComboBox(cmb, arr);
		}
		public static function setComboYear(cmb:ComboBox):void {
			var arr:Array = new Array();
			for (var i:int = 1980; i < 2014; i++) 
			{
				arr.push(""+(i + 1));
			}
			Functions.setComboBox(cmb, arr);
		}
		public static function getRecords(data:String, delimiter:String = "|"):Array {
			var arr:Array = data.split(delimiter);
			if (arr.length > 0) {
				if (String(arr[0]).replace(" ","") == "") {
					return new Array();
				}else {
					return arr;
				}
			}else {
				return arr;
			}
		}
		public static function hideColumn(table:DataGrid,col:int):void {
			table.getColumnAt(col).setWidth(0);
			table.getColumnAt(col).resizable = false;
			
		}
		
		public static function formatPicture(bitmap:DisplayObject, width:Number, height:Number):void {
			var newwidth:Number;
			var newheight:Number;
			var percent:Number;
			if (bitmap.width > bitmap.height) {
				var diffx:Number = bitmap.width - width;
				percent = (diffx / bitmap.width) * 100;
			}else if (bitmap.width < bitmap.height) {
				var diffy:Number = bitmap.height - height;
				percent = (diffy / bitmap.height) * 100;
			}else {
				percent = ((bitmap.height - height) / bitmap.height ) * 100;
			}
			bitmap.width = bitmap.width - ((percent / 100) * bitmap.width);
			bitmap.height = bitmap.height - ((percent / 100) * bitmap.height);
		}
		public static function isObjectInArray(arr:Array,object:Object):Boolean {
			var inarr:Boolean = false;
			for (var i:int = 0; i < arr.length; i++ ) {
				if (arr[i] == object) {
					inarr = true;
					break;
				}
			}
			return inarr;
		}
		
		public static function formatDate(date:String):String {
			var d:Array = date.split("-");
			var year:int = int(d[0]);
			var month:int = int(d[1]);
			var day:int = int(d[2]);
			return MONTHS[month - 1] + " " + day +", " + year;
		}
		public static function formatInteger(num:int,count:int):String {
			var ret:String = "";
			count = count - num.toString().length;
			for (var i:int = 0; i < count; i++ ) {
				ret += "0";
			}
			return (ret + num);
		}
		public static function shuffleArray(arr:Array):Array {
			var arr1:Array = new Array();
			var ran:int;
			while (arr.length > 0) {
				ran = int(Math.round(Math.random() * (arr.length - 1)));
				arr1.push(arr[ran]);
				arr.splice(ran, 1);
			}
			return arr1;
		}
		public static function cloneArray(source:Object):*
		{
			var myBA:ByteArray = new ByteArray();
			myBA.writeObject(source);
			myBA.position = 0;
			return(myBA.readObject());
		}
		public static function getAbsoluteValue(num:Number):Number{
			if (num < 0) {
				return -1 * num;
			}else {
				return num;
			}
		}
		public static function getUniqueLetters(s:String):Array {
			var arr:Array = new Array();
			for (var i:int = 0; i < s.length; i++ ) {
				if (arr.indexOf(s.charAt(i)) == -1) {
					arr.push(s.charAt(i));
				}
			}
			return arr;
		}
		public static function getFormatString(s:String):String {
			return s.replace("\\","\\\\").replace("'","\'");
		}
		public static function setButtonEvents(buttons:Array = null):void {
			TweenPlugin.activate([ScalePlugin]);
			if (buttons != null) {
				for each (var item:SimpleButton in buttons) 
				{
					item.addEventListener(MouseEvent.ROLL_OVER, function(e1:MouseEvent):void {
						TweenLite.to(MouseEvent(e1).currentTarget, 0.1,new TweenLiteVars().scale(1.2,false));
					});
					item.addEventListener(MouseEvent.ROLL_OUT, function(e2:MouseEvent):void {
						TweenLite.to(MouseEvent(e2).currentTarget, 0.1, new TweenLiteVars().scale(1, false));
					});
				}
			}
		}
		public static function intro(mc:MovieClip,sec:Number=0.5):void {
			TweenPlugin.activate([ScalePlugin, TransformAroundCenterPlugin, AutoAlphaPlugin]);
			TweenLite.to(mc, 0, new TweenLiteVars().transformAroundCenter( { scaleX: 0, scaleY:0 } ).autoAlpha(0));
			TweenLite.to(mc, sec, new TweenLiteVars().transformAroundCenter({scaleX: 1, scaleY: 1}).autoAlpha(1));
		}
		public static function outro(mc:MovieClip, sec:Number=0.5, oncomplete:Function=null,params:Array=null):void {
			TweenPlugin.activate([ScalePlugin, TransformAroundCenterPlugin, AutoAlphaPlugin]);
			TweenLite.to(mc, sec, new TweenLiteVars().transformAroundCenter( { scaleX: 0, scaleY:0 } ).autoAlpha(0).onComplete(oncomplete,params));
		}
		public static function getArrayToString(arr:Array ):String {
			var s:String = "";
			for (var i:int = 0; i < arr.length; i++) 
			{
				if (s == "") s = arr[i];
				else s += "|" + arr[i];
			}
			return s;
		}
	}

}