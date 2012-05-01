package  
{
	import flash.display.Sprite;
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
	import as3isolib.display.scene.IsoScene;
	import as3isolib.display.scene.IsoGrid;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import EightBitArena;
	
	
	public class endGameDisplay extends Sprite
	{
		private var __MenuArray:Array = new Array("play again", "play again");	
		private var buttonNames:Array = new Array("play again", "play again");
		private var buttons:Array = new Array();
		private var testMap:Map;
		private var movedAlready:Boolean;
		public var xcenter:Number;
		public var ycenter:Number;
		public var gameManager:GameManager;
		public var winner:Number;
		
		public function endGamePlayDisplay(gamemanager:GameManager,winner:Number)
		{
			this.gameManager = gamemanager;
			xcenter = stage.stageWidth / 2;
			ycenter = stage.stageHeight / 2;
			this.winner = winner;
			drawMenu();
		}
		
		// draw the menu
		private function drawMenu():void
		{
			
			//this var holds x position of the next button in the menu
			var xPos:Number = xcenter;
			var yPos:Number = ycenter;
			//create a holder that will contain the menu
			var menuHolder:Sprite = new Sprite();
			//add the holder to the stage
			addChild(menuHolder);
			//create text formatting for the text fields in the menu
			var format:TextFormat = new TextFormat();
			format.font = "Verdana";
			format.color = 0xFDFDFD;
			format.size = 12;
			format.bold = true;
			
			
			//loop thru the array, create each item listed in the array
			for (var i in __MenuArray)
			{
				//create the button
				var button:Sprite = new Sprite();
				button.name = buttonNames[i];
				//disable the mouse events of all the objects within the button
				button.mouseChildren = false;
				//make sprite behave as a button
				button.buttonMode = true;
				//create a label for the down button state
				var label:TextField = new TextField();
				label.autoSize = TextFieldAutoSize.LEFT;
				label.selectable = false;
				label.defaultTextFormat = format;
				label.text = __MenuArray[i];
				//create an up state for the button
				var up:Sprite = new Sprite();
				up.graphics.lineStyle(1, 0x000000);
				up.graphics.beginFill(0xFF30FF);
				up.graphics.drawRect(0, 0, 100, 30);
				up.name = "up";
				//create an over state for the button
				var over:Sprite = new Sprite();
				over.graphics.lineStyle(1, 0x000000);
				over.graphics.beginFill(0xFD99FF);
				over.graphics.drawRect(0, 0, 100, 30);
				over.name = "over";
				//adder the states and label to the button
				button.addChild(up);
				button.addChild(over);
				button.addChild(label);
				//position the text in the center of the button
				label.x = (button.width / 2) - (label.width / 2);
				label.y - (button.height / 2) - (label.height / 2);
				// add mouse events to the button
				//add the button to the holder
				menuHolder.addChild(button);
				//position the button
				button.x = xPos;
				button.y = yPos;
				//increase the x position for the next button
				
				yPos += button.height +2;
				//hide the over state of the button
				over.alpha = 0;
				
				buttons.push(button);
			}
			//
			buttons[0].addEventListener(MouseEvent.CLICK, startButtonListener);
			buttons[1].addEventListener(MouseEvent.CLICK, optionsButtonListener);
		
	}
	private function displayActiveState(event:MouseEvent):void
	{
		// Show the over state of the button.
		event.currentTarget.getChildByName("over").alpha = 100;
	}

  
    private function displayInactiveState(event:MouseEvent):void 
	{
      // Hide the over state of the button.
      event.currentTarget.getChildByName("over").alpha = 0;
    }
	
	private function startButtonListener(a:MouseEvent):void // button#0 listener for start game
	{
		eb.SetGamestate(4);
		eb.LoadGame();
		
	}
	
	private function optionsButtonListener(event:MouseEvent):void // button#1 listener for options
	{
		
	}
	public function returnchoice():Number
	{
		return Gamestate;
	}
		
	}
}