//========================
//Map.as
//========================
// - The Parent class for the individual maps/gameboards 
// - Contains:
//		- Grid size
//		- Viewport bounds (Unimplemented)
// 		- Team formation bounds (Unimplemented)
//		- Configuration for each gameplay map (Unimplemented)

package as3isolib.display.scene
{
	public class Map extends IsoGrid
	{
		
		public function Map() 
		{
			setGridSize(15, 15, 0);
			cellSize = 50;
			showOrigin = false;
			//gridlines = new Stroke();
		}
		
	}

}