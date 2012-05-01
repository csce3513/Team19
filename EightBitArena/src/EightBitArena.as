//==================================================
//8-Bit Arena
//==================================================
//A Mobile application project by:
//	Brett Gregory
//	Annabelle Young
//	Christopher Atwood
//	Michael Montgomery
//
//A Project for Software Engineering (CSCE 3513)
//==================================================


//========================
//EightBitArena.as
//========================
// - The main class of the application
// - Contains:
//		- GameStateManager (Unimplemented)
//		- Viewport loading (Unimplemented)
// 		- Control schemes (Unimplemented)
//		- Other features not yet added 

package  
{
	import flash.display.MovieClip;
	import flash.events.*;
	import Manager_Classes.GameManager;
	import AllTests;
	import asunit.textui.TestRunner;
	import SMenu;
	
	//public var turn:Number; // odd will be player 1 moves, even will be player 2 moves.
	
 
	public class EightBitArena extends MovieClip 
	{
		
		//Gamestate Manager Integer
		//-----------------------------------------
		
		//- 1 : MainMenu
		//- 2 : OptionsMenu
		//- 3 : TeamSelection
		//- 4 : GameInProgress
		//- 5 : EndGame
		
		private var gameManager:GameManager;
		private var frontmenu:SMenu;
		public var gamestate:Number = 1;
		//Constructor
		public function EightBitArena() 
		{
			stage.addEventListener(Event.ENTER_FRAME, Update);
			LoadMenu();
		}
		
		//Create Update method
		public function Update(e:Event): void {
			
			switch(gamestate)
			{
			case 1:
				break;
			case 2:
				break;
			case 3:
				break;
			case 4:
				{
					//LoadGame();
					gameManager.Update();
					break;
				}
				case 5:
					{
						
					}
			
			}
	}
		
		//Create Getters / Setters for gameState
		public function SetGamestate(gamestate:Number): void {
				this.gamestate = gamestate;
		}
		
		public function GetGamestate(): Number {
				return gamestate;
		}
		
		
		//Create Load Game method 
		public function LoadGame(): void
		{
				deleteMenu();
				gameManager = new GameManager(stage,this);
				addChild(gameManager);	
		}
		//create load menu method
		public function LoadMenu():void
		{
			frontmenu = new SMenu(stage, gamestate,this);
			addChild(frontmenu);
		}
		//delete opening menu
		public function deleteMenu():void
		{
			if (contains(frontmenu))
			{
			removeChild(frontmenu);
			}
		}
		//delete gamemanager
		
			
			
		
	}
}

