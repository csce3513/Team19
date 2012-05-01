//========================
//GameManager.as
//========================
// - This class runs the gameplay elements, loads all game elements, and draws them all
// - Contains:
//		- Loading graphical assets
//		- Viewport loading (Unimplemented)
// 		- Control schemes (Unimplemented)
//		- Update method to render the scenes at every frame drawing event
package Manager_Classes 
{
	import adobe.utils.CustomActions;
	import as3isolib.display.IsoSprite;
	import as3isolib.display.primitive.IsoRectangle;
	import as3isolib.display.primitive.Tile;
	import as3isolib.display.scene.Map;
	import as3isolib.display.scene.TheWoods;
	import champfiles.zeek;
	import champfiles.bunneh;
	import champfiles.zora;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.media.Sound;
	import flash.geom.Point;
	import as3isolib.display.primitive.PlayerObject;
	import as3isolib.display.primitive.GameObject;
	import as3isolib.display.Camera;
	import flash.display.Stage;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.display.scene.IsoGrid;
	import flash.events.Event;
	import AllTests;
	import asunit.textui.TestRunner;
	import gameMenu
	import flash.events.MouseEvent;
	import as3isolib.events.IsoEvent;
	import HUD;
	
	public class GameManager extends MovieClip 
	{
		//------
		//Variables we're not deleting
		//------
		public var activeUnit:PlayerObject;  // we just use this as a temporary copy for the units we click
		public var tempUnit:PlayerObject; // we just use this as temporary copy for units we mouse-over
		private var camera:Camera; 
		private var gridHolder:IsoScene; 
		private var scene:IsoScene;
		private var testMap:TheWoods;
		//These arrays store the champions currently on the screen for each player
		private var player1Champs:Array; 
		private var player2Champs:Array;
		private var panPt:Point;
		private var zoom:Number = 1;
		public var menu:gameMenu;
		public var hud:HUD;
		public var teststring:String;
		//This number keeps track of whose turn it is
		//1: Player 1's turn
		//2: Player 2's turn
		private var playerTurn:Number;
		private var attacking:Boolean;

		//keywords used for unit movement functions.
		private var enter:uint = 13;
		private var camerapanleft:uint = 65;
		private var camerapanright:uint = 68;
		private var camerapanup:uint = 87;
		private var camerapandown:uint =  83;		
		
		//Background image
		[Embed(source='/Images/sky.jpg')]
		private var sky:Class;
		private var background:Bitmap = new sky();
		
		//Variables for fighting
		[Embed(source = '/Music/Street fighter defeat.mp3')]
		private var sfdeath:Class;
		private var death:Sound = new sfdeath();
		[Embed(source = '/Music/Street_fighter_punch.mp3')]
		private var sfhit:Class;
		private var hit:Sound = new sfhit();
		
		//Variables for music
		[Embed(source = '/Music/Laudamus_te_Deum.mp3')]
		private var mySound:Class;
		private var lulu:Sound = new mySound();
		
		
		
		public function GameManager(stage:Stage) 
		{
			playerTurn = 1;
			teststring = "* ";   // since i can't seem to get the activetarget to report back from the mouse-over listener, used this just so stuff would compile
			camera = new Camera(stage.stageWidth,stage.stageHeight);
			scene  = new IsoScene();
			gridHolder = new IsoScene();
			testMap = new TheWoods(this);
			menu = new gameMenu(this, testMap);
			hud = new HUD(this, testMap);
			player1Champs = new Array();
			player2Champs = new Array();
			
			//music
			lulu.play();
			
			//background
			background.width = 800;
			background.height = 600;
			addChild(background);
			
			//Adding champions for each player
			player1Champs.push(new zeek(testMap, 1, 300, 100));
			player1Champs.push(new bunneh(testMap, 1, 400, 100));
			player1Champs.push(new zora(testMap, 1, 500, 100));
			player1Champs.push(new zeek(testMap, 1, 600, 100));
			player1Champs.push(new zeek(testMap, 1, 700, 100));
			
			player2Champs.push(new zeek(testMap, 2, 300, 1800));
			player2Champs.push(new bunneh(testMap, 2, 400, 1800));
			player2Champs.push(new zora(testMap, 2, 500, 1800));
			player2Champs.push(new zeek(testMap, 2, 600, 1800));
			player2Champs.push(new zeek(testMap, 2, 700, 1800));
			
			for (var i:Number = 0; i < player1Champs.length; i++)
			{
				scene.addChild(player1Champs[i]);
				player1Champs[i].addEventListener(MouseEvent.CLICK, champClick);
				player1Champs[i].addEventListener(MouseEvent.MOUSE_OVER, displayHUD);  // mouse over event listener to display HUD
				player1Champs[i].addEventListener(MouseEvent.MOUSE_OUT, removeHUD);	// mouse out event to remove HUD
			}
			
			for (var j:Number = 0; j < player2Champs.length; j++)
			{
				scene.addChild(player2Champs[j]);
				player2Champs[j].addEventListener(MouseEvent.CLICK, champClick);
				player2Champs[j].addEventListener(MouseEvent.MOUSE_OVER, displayHUD);  // mouse over event listener to display HUD
				player2Champs[j].addEventListener(MouseEvent.MOUSE_OUT, removeHUD);	// mouse out event to remove HUD
			}
			
			//Unit Testing Code
			//------
			//var unittests:TestRunner = new TestRunner();  // don't delete this shit i need it
			//stage.addChild(unittests);
			//unittests.start(AllTests, null, TestRunner.SHOW_TRACE);
			//------
			addChild(camera);
			
			gridHolder.addChild(testMap);
			camera.addScene(gridHolder);
			camera.addScene(scene);

			// add listeners for stage object
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, viewZoom);
			//add listeners for camera (hold shift down to use the camera)
			stage.addEventListener(MouseEvent.MOUSE_DOWN, viewMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, viewPan);
			stage.addEventListener(MouseEvent.MOUSE_UP, viewMouseUp);
		}
			
		//Camera Control Functions	
		private function viewMouseDown(event:MouseEvent):void
		{
			if (event.shiftKey)
			{
			panPt = new Point(stage.mouseX, stage.mouseY);
			camera.addEventListener(MouseEvent.MOUSE_MOVE, viewPan);
			camera.addEventListener(MouseEvent.MOUSE_DOWN, viewMouseUp);
			}
		}
		private function viewPan(e:MouseEvent):void
		{
			if (e.shiftKey)
			{
			camera.panBy(panPt.x - stage.mouseX, panPt.y - stage.mouseY);
			panPt.x = stage.mouseX;
			panPt.y = stage.mouseY;
			}
		}
		private function viewMouseUp(e:MouseEvent):void
		{
			if (e.shiftKey)
			{
			camera.removeEventListener(MouseEvent.MOUSE_MOVE, viewPan);
			camera.removeEventListener(MouseEvent.MOUSE_UP, viewMouseUp);
			}
		}
		private function viewZoom(e:MouseEvent):void
		{
			if(e.delta > 0)
			{
				zoom +=  0.10;
			}
			if(e.delta < 0)
			{
				zoom -=  0.10;
			}
			camera.currentZoom = zoom;
		}
		// end camera control functions
		// event listeners for player objects begins here ---------------------------------------------------------------
		private function champClick(a:Event):void   
		{
			var unitClicked:PlayerObject = a.target as PlayerObject;
			
			if (playerTurn == unitClicked.getPlayer())
			{
				if (activeUnit == null)
				{
					addChild(menu);
					activeUnit = a.target as PlayerObject;
					//centers the camera on the thing you click on
					camera.centerOnIso(a.target as PlayerObject);
				}
				else if (activeUnit == a.target as PlayerObject)
				{
					testMap.clearMoves();
					testMap.clearAttacks();
					setAttacking(false);
					activeUnit = null;
					removeChild(menu);
				}
			}
		}
		
		private function champAttackClick(a:Event):void   
		{
			var unitClicked:PlayerObject = a.target as PlayerObject;
			
			if (testMap.checkInRange(unitClicked))
			{
				var damage:Number = activeUnit.getDamage();
				var index:Number;
				if (playerTurn == 1)
				{
					for (var i:Number = 0; i < player2Champs.length; i++)
					{
						if (unitClicked == player2Champs[i])
						{
							unitClicked = player2Champs[i];
							index = i;
						}
					}
				}
				else 
				{
					for (var j:Number = 0; j < player1Champs.length; j++)
					{
						if (unitClicked == player1Champs[j])
						{
							unitClicked = player1Champs[j];
							index = j;
						}
					}
				}
				
				var health:Number = unitClicked.getHealth();
				hit.play();
				trace("Health was : "+ health);
				health = health - damage;
				//If enemy is dead, remove it from the field
				
				if (health <= 0)
				{
					death.play();
					if (playerTurn == 1)
					{
						scene.removeChild(player2Champs[index]);
						player2Champs.splice(index, 1);
					}
					else
					{
						scene.removeChild(player1Champs[index]);
						player1Champs.splice(index, 1);
					}
				}
				else	
					unitClicked.setCurrentHealth(health);
				trace("Health is now : "+ unitClicked.getHealth());
				activeUnit = null;
				testMap.clearMoves();
				testMap.clearAttacks();
				setAttacking(false);
				removeChild(menu);
				if (playerTurn  == 1)
					playerTurn = 2;
				else
					playerTurn = 1;
			}
		}
		//----------------End Player Object Event Listeners
		
		public function sendUnitTo(point:Point):void
		{
			activeUnit.moveTo(point.x, point.y, 0);
			activeUnit = null;
			testMap.clearMoves();
			testMap.clearAttacks();
			setAttacking(false);
			removeChild(menu);
			if (playerTurn  == 1)
				playerTurn = 2;
			else
				playerTurn = 1;
		}
		
		private function displayHUD(event:Event):void   // can't get the tempunit name to report back to HUD as it should :- /
		{
			tempUnit = event.target as PlayerObject;
			teststring = tempUnit.GetName();
			
			if (tempUnit != null)
			{
			addChild(hud);
			}
		}

  
		private function removeHUD(event:Event):void  // removes the HUD when u un-mouse-over a player object
		{
			removeChild(hud);
		}
		//-----------------------------------------------------------------------------------------------------------------
		//Update function: have this function render both scenes on every frame update and remove the render calls in the constructor
		public function Update(): void 
		{
			scene.render();	
			gridHolder.render();
		}
		
		public function getPlayerTurn():Number 
		{
			return playerTurn;
		}
		
		public function setAttacking(attacking:Boolean):void 
		{
			if (attacking == true)
			{
				this.attacking = true;
				if (playerTurn == 1)
				{
					for (var j:Number = 0; j < player2Champs.length; j++)
						player2Champs[j].addEventListener(MouseEvent.CLICK, champAttackClick);
				}
				else 
				{
					for (var i:Number = 0; i < player1Champs.length; i++)
						player1Champs[i].addEventListener(MouseEvent.CLICK, champAttackClick);
				}
			}
			else 
			{
				this.attacking = false;
				if (playerTurn == 1)
				{
					for (var m:Number = 0; m < player2Champs.length; m++)
						player2Champs[m].removeEventListener(MouseEvent.CLICK, champAttackClick);
				}
				else 
				{
					for (var n:Number = 0; n < player1Champs.length; n++)
						player2Champs[n].removeEventListener(MouseEvent.CLICK, champAttackClick);
				}
			}
		}
	}
}
