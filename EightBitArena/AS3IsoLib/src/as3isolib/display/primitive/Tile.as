	//====================================================================
	// TILE.AS
	//====================================================================
	// Manager class that will communicate tile dimensions
	// in terms that are easy to understand. each tile will be 50x50 pixels.
	// the gameboard is limited to 15 tiles by 15 tiles, so 750 pixelsx750
	// this class creates functionality to impliment each tile as an object.
	// -------------------------------------------------------------------

package as3isolib.display.primitive
{
	import as3isolib.display.IsoSprite;
	import flash.geom.Point;
	import as3isolib.display.scene.Map;
	import as3isolib.display.primitive.GameObject;
	import as3isolib.display.primitive.IsoRectangle;
	import flash.events.*;
	import as3isolib.graphics.SolidColorFill;
	import as3isolib.graphics.Stroke;
	
	public class Tile extends IsoRectangle 
	{
		private var coord:Point;
		private var occupied:Boolean;
		private var occupant:String;
		private var tileName:String;
		public var active:Boolean;
		private var map:Map;
		// end variable declorations
		public function Tile(x:Number, y:Number, map:Map)
		{
			this.x = x;
			this.y = y;
			occupied = false;
			//Set this tile's location in 50 pixel increments
			coord = new Point(x, y);
			active = false;
			occupied = false;
			setSize(50, 50, 0);
			this.map = map;
		}
		public function tilecoords():Point
		{
			return coord;
		}
		public function setcoords(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
		}
		public function setOccupied(champion:GameObject):void  // stores champion data that is standing on this tile
		{
			//occupant = champion;
		}
		public function checkOccupied(): Boolean // checks to see if something is here. 
		{	if (occupant != null )
			{
				return true;
			}
			else
			return false;
		}
		public function getOccupant():void     // gets occupant of tile's info out. use this if you KNOW somebody is in this tile
		{
			//return occupant;
		}
		public function setTileActive():void
		{
			fill = new SolidColorFill(0x0033FF, 1);
			active = true;
			addEventListener(MouseEvent.CLICK, clicked);
		}
		public function setTileInactive():void
		{
			fill = new SolidColorFill(0xFFFFFF, 1);
			active = false;
			removeEventListener(MouseEvent.CLICK, clicked);
		}
		public function checkActive():Boolean
		{
			if (active == true)
			return true;
			else
			return false;
		}
		
		private function clicked(e:Event):void
		{
			map.tileToMoveTo(coord);
		}
	}
}



