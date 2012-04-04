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
	public class PlayerObject extends GameObject 
	{
		//------
		//Champion Statistics
		//------
		private var name:String; 
		private var attDamage:Number;   // - Base damage done on basic attack
		private var attRange:Number;       // - Range of the basic attack : all melee champs have a range of 1
		private var movement:Number;   // - Number of total tiles this champ can move in 1 turn
		private var critChance:Number;   // - Chance to critically hit in percentage (value of 100 = 100% crit chance)
		private var currentState:String;   // - The Unit State the unit is currently affected by
		private var currentFacing:String; // - The direction the unit is currently facing (Possible values = "left", "right", "up", "down")
		
		//------
		//Global Statistics
		//------
		// - To be implemented later
		
		public function PlayerObject() 
		{
			
		}
		
		//Will need an update function
		
	}
}