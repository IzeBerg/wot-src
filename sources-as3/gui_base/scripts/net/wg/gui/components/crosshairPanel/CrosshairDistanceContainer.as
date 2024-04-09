package net.wg.gui.components.crosshairPanel
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CrosshairDistanceContainer extends MovieClip implements IDisposable
   {
      
      private static const DISTANCE_SHOW_FRAME:uint = 1;
      
      private static const DISTANCE_START_HIDE_FRAME:uint = 2;
      
      private static const DISTANCE_HIDE_FRAME:uint = 60;
       
      
      public var distanceField:CrosshairDistanceField = null;
      
      private var _disposed:Boolean = false;
      
      public function CrosshairDistanceContainer()
      {
         super();
      }
      
      public function clearDistance(param1:Boolean) : void
      {
         if(param1)
         {
            gotoAndStop(DISTANCE_HIDE_FRAME);
         }
         else
         {
            gotoAndPlay(DISTANCE_START_HIDE_FRAME);
         }
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         if(this.distanceField)
         {
            this.distanceField.dispose();
            this.distanceField = null;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setDistance(param1:String) : void
      {
         gotoAndStop(DISTANCE_SHOW_FRAME);
         this.distanceField.setDistance(param1);
      }
      
      public function setDistanceVisibility(param1:Boolean) : void
      {
         gotoAndStop(!!param1 ? DISTANCE_SHOW_FRAME : DISTANCE_HIDE_FRAME);
      }
   }
}
