package net.wg.gui.components.crosshairPanel
{
   import flash.geom.Rectangle;
   
   public class CrosshairWithCassette extends CrosshairBase
   {
      
      private static const RELOAD_TIME_BLINK_Y_SHIFT:int = -10;
       
      
      public function CrosshairWithCassette()
      {
         super();
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
   }
}
