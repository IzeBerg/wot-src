package net.wg.gui.bootcamp.battleTopHint
{
   import net.wg.gui.bootcamp.battleTopHint.containers.HintContainer;
   import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
   import net.wg.infrastructure.base.meta.IBCBattleTopHintMeta;
   import net.wg.infrastructure.base.meta.impl.BCBattleTopHintMeta;
   import scaleform.clik.motion.Tween;
   
   public class BCBattleTopHint extends BCBattleTopHintMeta implements IBCBattleTopHintMeta
   {
      
      private static const FRAME_COMPLETE_FINISH:int = 141;
      
      private static const FRAME_SHOW_FINISH:int = 65;
      
      private static const PENETRATION_HIGH:String = "high";
      
      private static const PENETRATION_LOW:String = "low";
      
      private static const PENETRATION_HINT_Y:int = 20;
      
      private static const COLOR_PURPLE:int = 8616446;
      
      private static const COLOR_RED:int = 16716820;
       
      
      public var hintContainer:HintContainer = null;
      
      public var penetrationHint:AnimatedTextContainer = null;
      
      private var _tween:Tween;
      
      public function BCBattleTopHint()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hintContainer.addFrameScript(FRAME_COMPLETE_FINISH,this.animFinishHandler);
         this.hintContainer.addFrameScript(FRAME_SHOW_FINISH,this.animFinishHandler);
         this.penetrationHint.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.hintContainer.addFrameScript(FRAME_COMPLETE_FINISH,null);
         this.hintContainer.addFrameScript(FRAME_SHOW_FINISH,null);
         this.hintContainer.dispose();
         this.hintContainer = null;
         this.penetrationHint.dispose();
         this.penetrationHint = null;
         this.disposeTween();
         super.onDispose();
      }
      
      public function as_closeHint() : void
      {
         if(this.hintContainer)
         {
            this.hintContainer.closeHint();
            animFinishS();
         }
      }
      
      public function as_hideHint() : void
      {
         this.hintContainer.hideHint();
         this.updateStage(App.appWidth,App.appHeight);
      }
      
      public function as_showHint(param1:int, param2:String, param3:Boolean) : void
      {
         this.hintContainer.showHint(param1,param2,param3);
         this.updateStage(App.appWidth,App.appHeight);
      }
      
      public function as_setPenetration(param1:String, param2:Boolean) : void
      {
         if(param1 == PENETRATION_HIGH || param1 == PENETRATION_LOW)
         {
            this.penetrationHint.gotoAndStop(param1);
            this.penetrationHint.visible = true;
            if(param1 == PENETRATION_HIGH)
            {
               this.penetrationHint.text = BOOTCAMP.PREBATTLE_HINT_PENETRATION_CHANCE_HIGH;
            }
            else if(param1 == PENETRATION_LOW)
            {
               this.penetrationHint.text = BOOTCAMP.PREBATTLE_HINT_PENETRATION_CHANCE_LOW;
               this.penetrationHint.textColor = !!param2 ? int(COLOR_PURPLE) : int(COLOR_RED);
            }
         }
         else
         {
            this.penetrationHint.visible = false;
         }
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this.hintContainer.x = param1 >> 1;
         this.hintContainer.y = 0;
         this.hintContainer.updateStage(param1,param2);
         this.penetrationHint.x = param1 >> 1;
         this.penetrationHint.y = (param2 >> 1) + PENETRATION_HINT_Y;
      }
      
      private function animFinishHandler() : void
      {
         animFinishS();
         this.hintContainer.stop();
      }
      
      private function disposeTween() : void
      {
         if(this._tween != null)
         {
            this._tween.paused = true;
            this._tween.dispose();
            this._tween = null;
         }
      }
   }
}
