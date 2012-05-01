
package  
{
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import as3isolib.display.scene.Map
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.NativeMenu;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.media.Sound;
	import flash.geom.*;
	import flash.geom.Point;
	import as3isolib.display.primitive.PlayerObject;
	import as3isolib.display.Camera;
	import flash.display.Stage;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.display.scene.IsoGrid;
	import Manager_Classes.GameManager;

	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	public class HUD extends Sprite
	{
		public var gameManager:GameManager;
		public var testMap:Map;
		public var tempstring:String = 'null';
		public var unitpicked:PlayerObject;
		public var intigrand:Number = 25;
		public var startcolumn:Number;
		public var labelarray:Array;
		public var healthmath:Number;
		public var healthtext:String;
		
		public function HUD(gameManager:GameManager,testMap:Map,unitpicked:PlayerObject) 
		{
			
			this.testMap = testMap;
			this.gameManager = gameManager;
			this.unitpicked = unitpicked;
			labelarray = new Array();
			drawHUD();
		}
		public function drawHUD():void
		{
		//format text for the HUD
			var format2:TextFormat = new TextFormat();
			format2.font = "Verdana";
			format2.color = 0x000000;
			format2.size = 15;
			format2.bold = false;
			
			var format3:TextFormat = new TextFormat();
			format3.font = "Times New Roman";
			format3.color = 0x000000;
			format3.size = 12;
			format3.bold = false;
			
			var format4:TextFormat = new TextFormat();
			format4.font = "Times New Roman";
			format4.color = 0xFF0000;
			format4.size = 12;
			format4.bold = true;
		// create the topright button that shows the currently selected champion's stats
			var hud:Sprite = new Sprite();
			hud.mouseChildren = false;
			hud.buttonMode = false;
			
			var label2:TextField = new TextField();
			var hplabel:TextField = new TextField();
			var currenthplabel:TextField = new TextField();
			var movementlabel:TextField = new TextField();
			var attacklabel:TextField = new TextField();
			var healthtext:TextField = new TextField();
			
			//label2.autoSize = TextFieldAutoSize.RIGHT;
			label2.selectable = false
			label2.defaultTextFormat = format2;
			
			//hplabel.autoSize = TextFieldAutoSize.RIGHT;
			hplabel.selectable = false
			hplabel.defaultTextFormat = format3;
			
			//currenthplabel.autoSize = TextFieldAutoSize.RIGHT;
			currenthplabel.selectable = false
			currenthplabel.defaultTextFormat = format3;
			
			//movementlabel.autoSize = TextFieldAutoSize.RIGHT;
			movementlabel.selectable = false
			movementlabel.defaultTextFormat = format3;
			
			//attacklabel.autoSize = TextFieldAutoSize.RIGHT;
			attacklabel.selectable = false
			attacklabel.defaultTextFormat = format3;
			
			//healthtext.autoSize = TextFieldAutoSize.RIGHT;
			healthtext.selectable = false;
			healthtext.defaultTextFormat = format3;
			if (unitpicked.getHealth() < 1 / 2 * unitpicked.getMaxHealth())  // healthtext turns red at critical damage
			{
				healthtext.defaultTextFormat = format4;
			}
			
			label2.text = unitpicked.getName();
			movementlabel.text = String('movement:   ' + unitpicked.getMovement());
			attacklabel.text = String('attack:   ' + unitpicked.getDamage());
			healthtext.text = String(unitpicked.getHealth() + '  /  ' + unitpicked.getMaxHealth());
			
			labelarray.push(label2);
			labelarray.push(healthtext);
			labelarray.push(movementlabel);
			labelarray.push(attacklabel);
			
			startcolumn = (hud.height / 2) - (hud.height / 2);
			
				
				for (var w:Number = 0; w <= 3; w++)   // for loop for setting the position of the labels in the box
				{
					labelarray[w].y = (startcolumn)
					labelarray[w].x = (hud.width / 2) - (hud.width / 2);
					hud.addChild(labelarray[w]);
					startcolumn += intigrand;
				}
				
				hud.graphics.lineStyle(1, 0x000000);
				hud.graphics.beginFill(0xC0C0C0);
				hud.graphics.drawRect(0, 0, 150, 100);
				hud.alpha = 100;
				
			
			hud.x = 690;
			hud.y = 10;
			addChild(hud);
		}
		public function setPlayerName(strang:String):void
		{
			this.tempstring = strang;
		}
		public function getPlayerName():String
		{
			return tempstring;
		}
		
	}
}