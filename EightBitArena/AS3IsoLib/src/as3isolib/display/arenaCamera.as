package as3isolib.display 
{
	/**
	 * ...
	 * brett
	 */
	public class arenaCamera extends Camera
	{
		
		public function arenaCamera(stageWidth:Number, stageHeight:Number) 
		{
			super(stageWidth, stageHeight);
			this.addEventListener(
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
	}

}