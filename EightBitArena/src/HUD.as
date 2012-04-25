
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
		
		public function HUD(gameManager:GameManager,testMap:Map) 
		{
			
			this.testMap = testMap;
			this.gameManager = gameManager;
			drawHUD();
		}
		public function drawHUD():void
		{
		//format text for the HUD
			var format2:TextFormat = new TextFormat();
			format2.font = "Verdana";
			format2.color = 0x000000;
			format2.size = 12;
			format2.bold = true;
		// create the topright button that shows the currently selected champion's stats
			var hud:Sprite = new Sprite();
			hud.mouseChildren = false;
			hud.buttonMode = false;
			var label2:TextField = new TextField();
			label2.autoSize = TextFieldAutoSize.RIGHT;
			label2.selectable = false
			label2.defaultTextFormat = format2;
			label2.text = gameManager.teststring;
			
			//create an up state for the button
				var up:Sprite = new Sprite();
				up.graphics.lineStyle(1, 0x000000);
				up.graphics.beginFill(0x00FF00);
				up.graphics.drawRect(0, 0, 100, 30);
				up.name = "up";
				//create an over state for the button
				var over:Sprite = new Sprite();
				over.graphics.lineStyle(1, 0x000000);
				over.graphics.beginFill(0xFFCC00);
				over.graphics.drawRect(0, 0, 100, 30);
				over.name = "over";
				//adder the states and label to the button
				hud.addChild(up);
				hud.addChild(over);
				hud.addChild(label2);
			
			
			
				label2.x = (hud.width / 2) - (hud.width / 2);
				label2.y - (hud.height / 2) - (hud.height / 2);
			
				hud.graphics.lineStyle(1, 0x000000);
				hud.graphics.beginFill(0x00FF00);
				hud.graphics.drawRect(0, 0, 100, 30);
				hud.alpha = 100;
				
			
			hud.x = 690;
			hud.y = 10;
			addChild(hud);
		}
		
	}
}