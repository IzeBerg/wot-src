package net.wg.gui.battle.views.staticMarkers.commander.orders
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class RTSOrderIconAnimation extends BattleUIComponent
   {
       
      
      public var orderIcon:MovieClip = null;
      
      public var orderIconPing:MovieClip = null;
      
      public function RTSOrderIconAnimation()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.orderIcon = null;
         this.orderIconPing = null;
         super.onDispose();
      }
      
      public function setOrder(param1:Number) : void
      {
         this.orderIcon.gotoAndStop(param1);
         this.orderIconPing.gotoAndStop(param1);
      }
   }
}
