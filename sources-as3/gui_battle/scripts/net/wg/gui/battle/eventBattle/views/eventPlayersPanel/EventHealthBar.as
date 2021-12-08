package net.wg.gui.battle.eventBattle.views.eventPlayersPanel
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class EventHealthBar extends BattleUIComponent
   {
      
      private static const FX_FRAME:int = 2;
       
      
      public var fx:MovieClip = null;
      
      public var hpMask:MovieClip = null;
      
      public var fxMask:MovieClip = null;
      
      public function EventHealthBar()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.fx = null;
         this.hpMask = null;
         this.fxMask = null;
         super.onDispose();
      }
      
      public function getHpMaskWidth() : Number
      {
         return this.hpMask.width;
      }
      
      public function playFx(param1:Number, param2:Number) : void
      {
         if(param1 > param2)
         {
            this.fxMask.x = param2;
            this.fxMask.width = param1 - param2;
         }
         else
         {
            this.fxMask.x = param1;
            this.fxMask.width = param2 - param1;
         }
         this.fx.gotoAndPlay(FX_FRAME);
      }
   }
}
