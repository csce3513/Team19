//========================
//GameObject.as
//========================
// - The Parent class for all objects that will be rendered on the playing field
// - Contains:
//		- Collision Detection
// 		- Sprite information

package as3isolib.display.primitive 
{
	import flash.geom.Point;
	import as3isolib.display.IsoSprite;
	import as3isolib.display.scene.Map;
	
	public class GameObject  extends IsoSprite
	{
		protected var currentTile:Point;
		private var map:Map;
		private var activeunit:Boolean;             // each game object has a boolean parameter for being the active unit
		private var ChampionName:String;
		
		public function GameObject(map:Map) 
		{
			currentTile = new Point();
			currentTile.x = this.x;
			currentTile.y = this.y;
			activeunit = false;					// set to false by default.
			this.map = map;
		}
		
		public override function moveTo(x:Number, y:Number, z:Number ):void
		{
			var desiredTile:Point = new Point();
			desiredTile.x = x;
			desiredTile.y = y;
			if (!testMap.checkCollision(desiredTile))
			{
				this.x = x;
				this.y = y;
				this.z = z;
				currentTile.x = this.x;
				currentTile.y = this.y;
			}
		}
		
		
		
		//-----------------THESE NEED TO BE MOVED TO PLAYEROBJECT WHEN WE CREATE IT
		public function SetActiveUnit():void
		{
			activeunit = true;
		}
		public function RemoveActiveUnit():void 
		{
			activeunit = false;
		}
		public function SetName(name:String):void
		{
			this.ChampionName = name;
		}
		public function GetName():String
		{
			return ChampionName;
		}
		public function ReturnCondition():Boolean
		{
			if (activeunit = true)
			return true;
			else
			return false;
		//-----------------------------------------------------------------------------
	}
}
}