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
 
	public class EightBitArena extends MovieClip 
	{	
		//Gamestate Manager Integer
		//-----------------------------------------
		private var gamestate:Number;
		//- 1 : MainMenu
		//- 2 : OptionsMenu
		//- 3 : TeamSelection
		//- 4 : GameInProgress
		//- 5 : EndGame
		
		private var gameManager:GameManager;
		
		//Constructor
		public function EightBitArena() 
		{
			gamestate = 4;
			
			LoadGame();
			//Set up the on enter frame event listener for updating
			stage.addEventListener(Event.ENTER_FRAME,Update);
		}
		
		//Create Update method
		public function Update(e:Event): void {
			
			switch (gamestate){
			//case 1:
			//break;
			//case 2:
			//break;
			//case 3:
			//break;
			
			case 4:
				gameManager.Update();
				break;
			//case 5:
			//break;	
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
				gameManager = new GameManager(stage);
				addChild(gameManager);	
		}
	}
}