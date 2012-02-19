package as3isolib.display 
{
	import flash.display.InteractiveObject;
	/**
	 * ...
	 * @author 
	 */
	public class Camera extends IsoView
	{
		
		public function Camera(stageWidth:Number, stageHeight:Number) 
		{
			setSize(stageWidth, stageHeight);
			clipContent = true;
			showBorder = false;
		}
		
	}

}