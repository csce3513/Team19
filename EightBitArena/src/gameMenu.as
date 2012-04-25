//------------------------------------------------------
// class to hold information for the in game menu
// should be always active
// need to have a few options, and display a few things
// -- current players turn
// -- maybe current player's team summary
// -- menu for attacking/moving/special ability use will be a HUD that pops up when u click on the champion



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
	
	/**
	 * ...
	 * @author Brett
	 */
	public class gameMenu extends Sprite
	{
		public var buttonchoice:Number = 6;
		private var __MenuArray:Array = new Array("Attack", "Special", "Move", "Wait", "Cancle");		
		private var buttonNames:Array = new Array("Attack", "Special", "Move", "Wait", "Default");
		private var buttons:Array = new Array();
		private var gameManager:GameManager;
		private var testMap:Map;
		public function gameMenu(gameManager:GameManager,testMap:Map):void
		{
			this.testMap = testMap;
			this.gameManager = gameManager;
			drawMenu();
		}
		// draw the menu
		private function drawMenu():void
		{
			
			//this var holds x position of the next button in the menu
			var xPos:Number = 0;
			//create a holder that will contain the menu
			var menuHolder:Sprite = new Sprite();
			//add the holder to the stage
			addChild(menuHolder);
			//create text formatting for the text fields in the menu
			var format:TextFormat = new TextFormat();
			format.font = "Verdana";
			format.color = 0x000000;
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
				//create a labale for the down button state
				var label:TextField = new TextField();
				label.autoSize = TextFieldAutoSize.LEFT;
				label.selectable = false;
				label.defaultTextFormat = format;
				label.text = __MenuArray[i];
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
				button.addChild(up);
				button.addChild(over);
				button.addChild(label);
				//position the text in the center of the button
				label.x = (button.width / 2) - (label.width / 2);
				label.y - (button.height / 2) - (label.height / 2);
				// add mouse events to the button
				button.addEventListener(MouseEvent.MOUSE_OVER, displayActiveState);
				button.addEventListener(MouseEvent.MOUSE_OUT, displayInactiveState);
				//button.addEventListener(MouseEvent.CLICK, displayMessage);
				//add the button to the holder
				menuHolder.addChild(button);
				//position the button
				button.x = xPos;
				//increase the x position for the next button
				xPos += button.width + 2;
				//hide the over state of the button
				over.alpha = 0;
				
				buttons.push(button);
			}
			//add specific click mouse event listeners to each button for use in the menu 
			//buttons[0].addEventListener(MouseEvent.CLICK, attackButtonListener);
			//buttons[1].addEventListener(MouseEvent.CLICK, specialButtonListener);
			buttons[2].addEventListener(MouseEvent.CLICK, moveButtonListener); // adds the movement functionality to the move button[2]
			//buttons[3].addEventListener(MouseEvent.CLICK, waitButtonListener);
			buttons[4].addEventListener(MouseEvent.CLICK, cancleButtonListener);
			
			//position the menu
			menuHolder.x = 20;
			menuHolder.y = 20;
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

	// clicking on button mouse listeners begins here -------------------------------------------------------------------------------------
	private function attackButtonListener(event:MouseEvent):void // button#0 listener for attack
	{
		//attack functions called here
		// clicking the attacking button (calling this listener) should add additional listeners to every enemy champion to recieve damage
	}
	private function specialButtonListener(event:MouseEvent):void // button#1 listener for specials
	{
		// special functions called here
	}
    private function moveButtonListener(event:MouseEvent):void //button #2 listener for movement
	{
	  testMap.showMoves(gameManager.activeUnit);
	}
	private function waitButtonListener(event:MouseEvent):void // button #3 listener for waiting
	{
		// wait function called here
	}
	private function cancleButtonListener(event:MouseEvent):void // button #4 listener for cancle function
	{
		gameManager.activeUnit = null;
		testMap.clearMoves();
		gameManager.removeChild(this);
	}
	//--------------------------------------------------------------------------------------------------------------------------------------
}
}