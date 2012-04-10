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
	import champfiles.zeek;
	import as3isolib.display.scene.Map
	import champfiles.zeek;
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
	import AllTests;
	import asunit.textui.TestRunner;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuBuiltInItems;
	import flash.ui.ContextMenuClipboardItems;
	import flash.text.TextField;
	import flash.display.Shape;
	import flash.ui.ContextMenuItem;
	
	/**
	 * ...
	 * @author Brett
	 */
	public class gameMenu extends Sprite
	{
	  public var myContextMenu:ContextMenu;
	  public var menuLabel:String = "Reverse Colors";
	  public var textLabel:String = "Right Click";
	  public var redRectangle:Sprite;
	  public var label:TextField;
	  public var size:uint = 100;
	  public var black:uint = 0x000000;
	  public var red:uint = 0xFF0000;
	  
		public function gameMenu() 
		{
			super();
		}
		
		
			//-------------------
			// game menu code starts here
			//---------------------
			public function contextMenuExample()
			{
			myContextMenu = new ContextMenu();
			addChildren();
			removeDefaultItems();
			addCustomMenuItems();
			
			//redRectangle.myContextMenu = myContextMenu;
			}
			
		public function addChildren():void 
		{
			redRectangle = new Sprite();
			redRectangle.graphics.beginFill(red);
			redRectangle.graphics.drawRect(0, 0, size, size);
			addChild(redRectangle);
			redRectangle.x = size;
			redRectangle.y = size;
			label = createLabel();
			redRectangle.addChild(label);
		}
		
	    private function removeDefaultItems():void 
	 {
	  myContextMenu.hideBuiltInItems();
	  var defaultItems:ContextMenuBuiltInItems = myContextMenu.builtInItems;
	  defaultItems.print = true;
	  }
	  
	    public function addCustomMenuItems():void 
	 {
	  var item:ContextMenuItem = new ContextMenuItem(menuLabel);
	  myContextMenu.customItems.push(item);
	  item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
	  }
	  
	    private function menuSelectHandler(event:ContextMenuEvent):void 
	 {
	  trace("menuSelectHandler: " + event);
	  }
	  
	    private function menuItemSelectHandler(event:ContextMenuEvent):void 
	 {
	  trace("menuItemSelectHandler: " + event);
	  var textColor:uint = (label.textColor == black) ? red : black;
	  var bgColor:uint = (label.textColor == black) ? black : red;
	  redRectangle.graphics.clear();
	  redRectangle.graphics.beginFill(bgColor);
	  redRectangle.graphics.drawRect(0, 0, size, size);
	  label.textColor = textColor;
	  }
	  
	    private function createLabel():TextField 
	 {
	  var txtField:TextField = new TextField();
	  txtField.text = textLabel;
	  return txtField;
	 }
	}

}