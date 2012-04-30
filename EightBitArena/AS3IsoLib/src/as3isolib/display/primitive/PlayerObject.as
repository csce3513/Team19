//========================
//PlayerObject.as
//========================
// - The Parent class for all champions
// - Contains:
//		- Champion Statistics (HP, attack  damage, etc...)
//		- Global Statistics (# of kills, total damage dealt, etc...)
// 		- SpriteSheet / Animation code
//		- Actions
//				- Basic attack / Move / Special Ability
//		- Unit States
//				- Stunned / Silenced / Dead etc....


package as3isolib.display.primitive 
{
	import as3isolib.display.primitive.GameObject;
	import as3isolib.display.scene.Map;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import Manager_Classes.GameManager;
	import flash.events.Event;
	import flash.events.*;
	import as3isolib.display.Camera;
	import as3isolib.display.primitive.Tile
	import flash.display.Stage;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.display.scene.IsoGrid;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class PlayerObject extends  GameObject 
	{
		//------
		//Champion Statistics
		//------
		protected var champname:String;     //<<<<< THIS NEEDS TO BE MOVED IMPLEMENTED IN SPECIFIC CHAMP FILES
		protected var maxHealth:Number;     // base amount of health points
		protected var currentHealth:Number; // amount of health champ currently has.
		protected var attDamage:Number;   // - Base damage done on basic attack
		protected var attRange:Number;       // - Range of the basic attack : all melee champs have a range of 1
		protected var movement:Number;   // - Number of total tiles this champ can move in 1 turn
		protected var critChance:Number;   // - Chance to critically hit in percentage (value of 100 = 100% crit chance)
		protected var currentState:String;   // - The Unit State the unit is currently affected by
		protected var currentFacing:String; // - The direction the unit is currently facing (Possible values = "left", "right", "up", "down")
		protected var specialType:String; // The type of special this champion has: "move", "attack", "heal", "buff"
		protected var specialRange:Number;
		protected var specialCD:Number; //The special's cooldown in number of turns
		protected var specialCDMax:Number;
		public var playerNum:Number; //The player that this champ belongs to: 1 for Player1, 2 for Player2
		
		//------
		//Global Statistics
		//------
		private var kills:Number;
		private var damagedealt:Number;
		
		public function PlayerObject(testMap:Map, playerNum:Number, x:Number, y:Number) 
		{
			super();
			setSize(50, 50, 50);
			map = testMap;
			this.playerNum = playerNum;
			moveTo(x, y, 0);
		}
		
		//Will need an update function
		public override function moveTo(x:Number, y:Number, z:Number):void
		{
			var desiredTile:Point = new Point();
			desiredTile.x = x;
			desiredTile.y = y;
			if (playerNum == 1)
			{
				map.p1ObjCoords(currentTile, desiredTile);
			}
			else if (playerNum == 2)
			{
				map.p2ObjCoords(currentTile, desiredTile);
			}
			
			this.x = x;
			this.y = y;
			this.z = z;
			currentTile.x = this.x;
			currentTile.y = this.y;
		}
		
		//getters and setters for unit statistics.
		public function incrementCD():void 
		{
			specialCD++;
		}
		
		public function getCD():Number 
		{
			return specialCD;
		}
		
		public function getCDMax():Number 
		{
			return specialCDMax;
		}
		
		public function setCD(num:Number):void 
		{
			specialCD = num;
		}
		//name functions
		public function SetName(name:String):void  // may need to call this in champ select screen
		{
			this.champname = name;
		}
		
		public function getPlayer():Number 
		{
			return playerNum;
		}

		public function getSpecialType():String
		{
			return specialType;
		}
		
		public function getSpecialRange():Number
		{
			return specialRange;
		}
		
		public function GetName():String  
		{
			return champname;
		}
		// unit stat functions
		public function setHealth(maxHealth:Number):void			//setmaxhp
		{
			this.maxHealth = maxHealth;
		}
		
		public function setRange(attRange:Number):void			//setRange
		{
			this.attRange = attRange;
		}
		
		public function getRange():Number		//setmaxhp
		{
			return attRange;
		}
		
		public function setCurrentHealth(currentHealth:Number):void //setcurrenthp
		{
			this.currentHealth = currentHealth;
		}
		public function getHealth():Number
		{
			return currentHealth;
		}
		public function getMaxHealth():Number
		{
			return maxHealth;
		}
		public function setDamage(attDamage:Number):void //setdmg
		{
			this.attDamage = attDamage;
		}
		public function getDamage():Number
		{
			return attDamage;
		}
		public function setMovement(movement:Number): void //setmove
		{
			this.movement = movement;
		}
		public function getMovement():Number
		{
			return movement;
		}
		
		
		public function setCondition():void
		{
			this.activeunit = true;
		}
		public function ReturnCondition():Boolean  // used to check if the unit is the selected unit or not
		{
			if (activeunit = true)
			return true;
			else
			return false;
		}
		
		
	
	
}
}