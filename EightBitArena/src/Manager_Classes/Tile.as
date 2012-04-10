	//====================================================================
	// TILE.AS
	//====================================================================
	// Manager class that will communicate tile dimensions
	// in terms that are easy to understand. each tile will be 50x50 pixels.
	// the gameboard is limited to 15 tiles by 15 tiles, so 750 pixelsx750
	// this class creates functionality to impliment each tile as an object.
	// -------------------------------------------------------------------

package Manager_Classes 
{
	import flash.geom.Point;
	import as3isolib.display.scene.Map;
	import as3isolib.display.primitive.GameObject;
	import as3isolib.display.primitive.IsoRectangle;
	
	public class Tile extends IsoRectangle {
		
		
		private var coord:Point;
		private var occupied:Boolean;
		private var occupant:GameObject;
		private var name:String;
		
		public function Tile(x:Number, y:Number, name:String)
		{
			coord = new Point(x,y);
			occupied = false;
			this.name = name;
		}
		
		public function setTileName(name:String): void 
		{
			this.name = name;
		}
		
		public function getTileName():String
		{
			return name;
		}
		
		public function setoccupied(gameobject:GameObject):void
		{
			occupied = true;
			occupant = gameobject;
		}
		
		public function removeoccupied():void
		{
			occupied = false;
			occupant = null;
		}
		
		public function checkoccupied():String 
		{
			if (occupied = true)
			{
			return occupant.GetName();
			}
			else
			return null;
		}
		
	}

}