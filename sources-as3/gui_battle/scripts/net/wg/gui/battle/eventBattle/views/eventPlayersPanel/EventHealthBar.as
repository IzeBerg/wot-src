package net.wg.gui.battle.eventBattle.views.eventPlayersPanel
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.components.common.FrameStateCmpnt;
   
   public class EventHealthBar extends BattleUIComponent
   {
      
      private static const SELF_LABEL:String = "self";
      
      private static const REGULAR_LABEL:String = "regular";
       
      
      public var fx:EventHealthBarFx = null;
      
      public var hpBar:FrameStateCmpnt = null;
      
      public var hpMask:MovieClip = null;
      
      public var fxMask:MovieClip = null;
      
      public var bg:FrameStateCmpnt = null;
      
      public function EventHealthBar()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.fx.dispose();
         this.fx = null;
         this.hpBar.dispose();
         this.hpBar = null;
         this.hpMask = null;
         this.fxMask = null;
         this.bg.dispose();
         this.bg = null;
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
         this.fx.playAnim();
      }
      
      public function setSelfState(param1:Boolean) : void
      {
         var _loc2_:String = !!param1 ? SELF_LABEL : REGULAR_LABEL;
         this.fx.setBarFrame(_loc2_);
         if(_baseDisposed)
         {
            return;
         }
         this.hpBar.frameLabel = _loc2_;
         if(_baseDisposed)
         {
            return;
         }
         this.bg.frameLabel = _loc2_;
      }
   }
}
