//========================
//TheWoods.as
//========================
// - This is the class that stores the information and layout for the map The Woods
// - Contains:
//		- Grid size
// 		- Team formation bounds
//		- Configuration forthis gameplay arena

package as3isolib.display.scene 
{
	import flash.display.Bitmap;
	import as3isolib.display.primitive.Tile;
	import Manager_Classes.GameManager;
	import TerrainObject;
	import Manager_Classes.Pathfinder;
	import Manager_Classes.Path;
	
	public class TheWoods extends Map 
	{
		private var water1:TerrainObject;
		private var water2:TerrainObject;
		private var water3:TerrainObject;
		private var water4:TerrainObject;
		private var water5:TerrainObject;
		private var water6:TerrainObject;
		private var water7:TerrainObject;
		private var water8:TerrainObject;
	
		
		public function TheWoods(gameManager:GameManager) 
		{
			super(gameManager);
			setGridSize(25, 40, 0);
			var increment:Number = 50;
			var row:Number = 0;
			var column:Number = 0;
			var count:Number = 0;
			
			for (var i:Number = 0; i < gridSize[1]; i++)  // creates all the stupid tiles and does stuff
			{
			
				for (var j:Number = 0; j < gridSize[0]; j++)
				{
					tilesArray.push(new Tile(row, column, this, "tree"));//Change the rand parameter here to a string
					//If adding a water tile
					//push this tile's row, column as a point into terrainObj array
					//if(row = 600, row =700)
					addChild(tilesArray[count]);
					row += increment;
					count++;	
				}
				row = 0;
				column += increment;
			}
			
			water1 = new TerrainObject(this, 0, 500, "tree1");
			water2 = new TerrainObject(this, 50, 500, "tree2");
			water3 = new TerrainObject(this, 100, 500, "tree1"); 
			water4 = new TerrainObject(this, 150, 500, "tree1");
			water5 = new TerrainObject(this, 200, 500, "tree2");
			water6 = new TerrainObject(this, 250, 500, "tree1");
			water7 = new TerrainObject(this, 300, 500, "tree1");
			water8 = new TerrainObject(this, 350, 500, "tree2");	
			addChild(water1);
			addChild(water2);
			addChild(water3); 
			addChild(water4);
			addChild(water5);
			addChild(water6);
			addChild(water7);
			addChild(water8);
		}
		
	}

}