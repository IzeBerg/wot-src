package net.wg.gui.components.crosshairPanel.components.artyScale
{
   import net.wg.infrastructure.base.SimpleContainer;
   
   public class ArtyIndicationScale extends SimpleContainer
   {
      
      private static const FRAMES_COUNT:uint = 120;
       
      
      private var _currentFrameNumber:int = 0;
      
      public function ArtyIndicationScale()
      {
         super();
      }
      
      public function updateData(param1:Number) : void
      {
         var _loc2_:int = Math.round(FRAMES_COUNT * param1) + 1;
         if(this._currentFrameNumber != _loc2_)
         {
            this._currentFrameNumber = _loc2_;
            this.gotoAndStop(this._currentFrameNumber);
         }
      }
   }
}
