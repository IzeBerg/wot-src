package net.wg.gui.components.crosshairPanel
{
   import flash.geom.Rectangle;
   
   public class CrosshairWithCassette extends CrosshairBase
   {
      
      private static const RELOAD_TIME_BLINK_Y_SHIFT:int = -10;
       
      
      private var _cassettePositions:Array = null;
      
      public function CrosshairWithCassette()
      {
         super();
         this._cassettePositions = this.getCassettePositions();
      }
      
      override protected function onDispose() : void
      {
         if(this._cassettePositions)
         {
            this._cassettePositions.splice(0,this._cassettePositions.length);
            this._cassettePositions = null;
         }
         super.onDispose();
      }
      
      override protected function updateNetType() : void
      {
         super.updateNetType();
         cassetteMC.y = this._cassettePositions[netType];
      }
      
      override protected function arrangeReloadTimeBlink() : void
      {
         var _loc1_:Rectangle = null;
         if(isAutoloader)
         {
            _loc1_ = autoloaderComponent.getTimerRect();
            reloadTimeBlink.x = autoloaderComponent.x + _loc1_.x + (_loc1_.width - reloadTimeBlink.width >> 1) | 0;
            reloadTimeBlink.y = autoloaderComponent.y + _loc1_.y + _loc1_.height + RELOAD_TIME_BLINK_Y_SHIFT | 0;
         }
         else
         {
            super.arrangeReloadTimeBlink();
         }
      }
      
      protected function getCassettePositions() : Array
      {
         return null;
      }
   }
}
