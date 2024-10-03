package net.wg.white_tiger.gui.battle.views.wtPlayersPanel.comps
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class BotHealthBar extends BattleUIComponent
   {
      
      private static const FX_FRAME_START:int = 2;
      
      private static const FRAME_NORMAL:String = "normal";
      
      private static const FRAME_CARRY:String = "carry";
       
      
      public var bar:MovieClip = null;
      
      public var fx:MovieClip = null;
      
      public var carryFx:MovieClip = null;
      
      public var hpMask:MovieClip = null;
      
      public var fxMask:MovieClip = null;
      
      protected var prevMaskX:Number = -1;
      
      protected var prevMaskWidth:Number = -1;
      
      public function BotHealthBar()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.bar = null;
         this.fx = null;
         this.carryFx = null;
         this.hpMask = null;
         this.fxMask = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.carryFx)
         {
            this.carryFx.visible = false;
         }
      }
      
      public function showHp(param1:Number) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Number = NaN;
         if(param1 >= 0)
         {
            _loc2_ = this.fx.currentFrame < FX_FRAME_START;
            if(_loc2_)
            {
               this.prevMaskX = this.getHpMaskX();
               this.prevMaskWidth = this.getHpMaskWidth();
            }
            gotoAndStop(totalFrames * (1 - param1));
            _loc3_ = this.getHpMaskWidth();
            this.fxMask.width = Math.abs(_loc3_ - this.prevMaskWidth);
            if(_loc2_)
            {
               this.fx.gotoAndPlay(FX_FRAME_START);
               if(this.carryFx)
               {
                  this.carryFx.gotoAndPlay(FX_FRAME_START);
               }
            }
         }
      }
      
      protected function getHpMaskX() : Number
      {
         return Boolean(this.hpMask) ? Number(this.hpMask.x) : Number(0);
      }
      
      protected function getHpMaskWidth() : Number
      {
         return Boolean(this.hpMask) ? Number(this.hpMask.width) : Number(0);
      }
      
      public function set isBombCarry(param1:Boolean) : void
      {
         this.fx.visible = !param1;
         if(this.carryFx)
         {
            this.carryFx.visible = param1;
         }
         if(this.bar)
         {
            this.bar.gotoAndStop(!!param1 ? FRAME_CARRY : FRAME_NORMAL);
         }
      }
   }
}
