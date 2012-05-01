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
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.media.Sound;
	import flash.geom.Point;
	import as3isolib.display.primitive.PlayerObject;
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
		public var eb:EightBitArena;
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
		private var attackingSpecial:Boolean;

		//keywords used for unit movement functions.
		private var enter:uint = 13;
		private var camerapanleft:uint = 65;
		private var camerapanright:uint = 68;
		private var camerapanup:uint = 87;
		private var camerapandown:uint =  83;		
		//Variables for music
		//[Embed(source = 'Music/Laudamus_te_Deum.mp3')]
		//private var mySound:Class;
		//private var lulu:Sound;
		public function GameManager(stage:Stage,eb:EightBitArena) 
		{
			this.eb = eb;
			playerTurn = 1;
			camera = new Camera(stage.stageWidth,stage.stageHeight);
			scene  = new IsoScene();
			gridHolder = new IsoScene();
			testMap = new TheWoods(this);
			menu = new gameMenu(this, testMap);
			
			player1Champs = new Array();
			player2Champs = new Array();
			
			//Adding champions for each player
			player1Champs.push(new zeek(testMap, 1, 300, 100));
			player1Champs.push(new bunneh(testMap, 1, 400, 100));
			player1Champs.push(new zeek(testMap, 1, 500, 100));
			player1Champs.push(new zeek(testMap, 1, 600, 100));
			player1Champs.push(new zeek(testMap, 1, 700, 100));
			
			player2Champs.push(new zeek(testMap, 2, 300, 1300));
			player2Champs.push(new bunneh(testMap, 2, 400, 1300));
			player2Champs.push(new zeek(testMap, 2, 500, 1300));
			player2Champs.push(new zeek(testMap, 2, 600, 1300));
			player2Champs.push(new zeek(testMap, 2, 700, 1300));
			
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
			if (player1Champs.length == 0)
			{
				eb.SetGamestate(5);
			}
			else if (player2Champs.length == 0)
			{
				eb.SetGamestate(5);
			}
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
		private function champAttackClick(a:Event):void   
		{
			trace("Champ clicked");
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
				trace("Health was : " + health);
				if(attackingSpecial)
					health = health - (damage * 2);
				else
					health = health - damage;
					trace("Health is : " + health);
				//If enemy is dead, remove it from the field
				if (health <= 0)
				{
					if (playerTurn == 1)
					{
						testMap.removeP2Champ(new Point(player2Champs[index].x, player2Champs[index].y));
						scene.removeChild(player2Champs[index]);
						player2Champs.splice(index, 1);
					}
					else
					{
						testMap.removeP1Champ(new Point(player1Champs[index].x, player1Champs[index].y));
						scene.removeChild(player1Champs[index]);
						player1Champs.splice(index, 1);
					}
				}
				else	
					unitClicked.setCurrentHealth(health);
				activeUnit = null;
				testMap.clearMoves();
				testMap.clearAttacks();
				if (attackingSpecial)
					activeUnit.setCD(0);
				incrementCD();
				setAttacking(false, false);
				removeChild(menu);
				if (playerTurn  == 1)
					playerTurn = 2;
				else
					playerTurn = 1;
				menu.setMoved(false);
			}
		}
		
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
					setAttacking(false, false);
					activeUnit = null;
					removeChild(menu);
				}
			}
		}
		//----------------End Player Object Event Listeners
		
		public function sendUnitTo(point:Point, special:Boolean):void
		{
			activeUnit.moveTo(point.x, point.y, 0);
			testMap.clearAttacks();
			setAttacking(false, false);
			menu.setMoved(true);
			if (special)
			{
				testMap.clearSpecial();
				activeUnit.setCD(0);
				incrementCD();
				if (playerTurn  == 1)
					playerTurn = 2;
				else
					playerTurn = 1;
				activeUnit = null;
				menu.setMoved(false);
				removeChild(menu);
			}
		}
		
		private function displayHUD(event:Event):void 
		{
			tempUnit = event.target as PlayerObject;
			hud = new HUD(this, testMap,tempUnit);
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
		
		public function setAttacking(_attacking:Boolean, special:Boolean):void 
		{
			if (_attacking)
			{
				if(special)
					attackingSpecial = special;
				this.attacking = true;
				if (playerTurn == 1)
				{
					for (var j:Number = 0; j < player2Champs.length; j++)
					{
						player2Champs[j].removeEventListener(MouseEvent.CLICK, champClick);
						player2Champs[j].addEventListener(MouseEvent.CLICK, champAttackClick);
					}
				}
				else 
				{
					for (var i:Number = 0; i < player1Champs.length; i++)
					{
						player1Champs[i].removeEventListener(MouseEvent.CLICK, champClick);
						player1Champs[i].addEventListener(MouseEvent.CLICK, champAttackClick);
					}
				}
			}
			else 
			{
				this.attacking = false;
				if (playerTurn == 1)
				{
					for (var m:Number = 0; m < player2Champs.length; m++)
					{
						player2Champs[m].removeEventListener(MouseEvent.CLICK, champAttackClick);
						player2Champs[m].addEventListener(MouseEvent.CLICK, champClick);
					}
				}
				else 
				{
					for (var n:Number = 0; n < player1Champs.length; n++)
					{
						player1Champs[n].removeEventListener(MouseEvent.CLICK, champAttackClick);
						player1Champs[n].addEventListener(MouseEvent.CLICK, champClick);
					}
				}
			}
		}
		
		public function wait():void 
		{
			activeUnit = null;
			testMap.clearMoves();
			testMap.clearAttacks();
			incrementCD();
			setAttacking(false, false);
			removeChild(menu);
			if (playerTurn  == 1)
				playerTurn = 2;
			else
				playerTurn = 1;
		}
		
		private function incrementCD():void 
		{
			if (playerTurn == 1)
			{
				for (var m:Number = 0; m < player2Champs.length; m++)
				{
					if (player2Champs[m].getCD() < player2Champs[m].getCDMax())
						player2Champs[m].incrementCD();
				}
			}
			else 
			{
				for (var n:Number = 0; n < player1Champs.length; n++)
				{
					if (player1Champs[n].getCD() < player1Champs[n].getCDMax())
						player1Champs[n].incrementCD();
				}
			}
		}
	}
}
