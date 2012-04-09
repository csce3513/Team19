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
	import flash.geom.Point;
	import as3isolib.display.scene.Map;
	import as3isolib.display.primitive.GameObject;
	import as3isolib.display.primitive.IsoRectangle;
	import flash.events.*;
	import as3isolib.graphics.SolidColorFill;
	import as3isolib.graphics.Stroke;
	
	
	public class Tile extends IsoRectangle {
		
		
		private var coord:Point;
		private var occupied:Boolean;
		private var occupant:GameObject;
		private var tileName:String;
		
		public function Tile(x:Number, y:Number, name:String)
		{
			this.x = x;
			this.y = y;
			this.occupied = false;
			this.occupant = null;
			
			//Set this tile's location in 50 pixel increments
			coord = new Point(x, y);
			occupied = false;
			tileName = name;
			setSize(50, 50, 0);
			
			//Event listeners
			addEventListener(MouseEvent.CLICK, setTileActive);
			
			//fill = new SolidColorFill(0x0033FF, 1);
			//fill = new SolidColorFill(0xFFFFFF, 1);
		}
		public function scanpieces():void  // scans the objects to see if any tiles are occupied.
		{
			
		}
		
		public function setoccupied(obj:GameObject):void
		{
			occupied = true;
			occupant = obj;
		}
		
		public function removeoccupied():void
		{
			occupied = false;
			occupant = null;
		}
		
		public function tilecoords():Point
		{
			return coord;
		}
		public function checkoccupied():Boolean 
		{
			if (occupied = true)
			{
				return true;
			}
			else
				return false;
		}
		public function setTileActive(e:Event):void
		{
			occupant.SetActiveUnit();
			trace("Active unit set");
		}
		
	}

}