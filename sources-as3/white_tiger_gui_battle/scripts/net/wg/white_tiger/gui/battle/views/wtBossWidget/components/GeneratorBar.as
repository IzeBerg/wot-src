package net.wg.white_tiger.gui.battle.views.wtBossWidget.components
{
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.components.controls.TextFieldContainer;
   
   public class GeneratorBar extends BattleUIComponent
   {
      
      private static const FRAME_LABEL_SHIELD_ONLINE:String = "shieldOnline";
      
      private static const FRAME_LABEL_SHIELD_OFFLINE:String = "shieldOffline";
      
      private static const FRAME_LABEL_SHIELD_ENDGAME:String = "shieldEndgame";
      
      private static const SHIELD_TIMER_FILTER:Array = [new DropShadowFilter(0,0,16711680,1,2,2,2,BitmapFilterQuality.HIGH)];
       
      
      public var generatorOne:Generator = null;
      
      public var generatorTwo:Generator = null;
      
      public var generatorThree:Generator = null;
      
      public var shieldTimerTF:TextFieldContainer = null;
      
      public function GeneratorBar()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.shieldTimerTF.dispose();
         this.shieldTimerTF = null;
         this.generatorOne.dispose();
         this.generatorTwo.dispose();
         this.generatorThree.dispose();
         this.generatorOne = null;
         this.generatorTwo = null;
         this.generatorThree = null;
      }
      
      override protected function configUI() : void
      {
         this.setShieldOnline();
         super.configUI();
      }
      
      public function resetGeneratorTimer(param1:Number) : void
      {
         if(currentFrameLabel != FRAME_LABEL_SHIELD_ONLINE)
         {
            return;
         }
         switch(param1)
         {
            case 1:
               this.generatorOne.resetGeneratorTimer();
               break;
            case 2:
               this.generatorTwo.resetGeneratorTimer();
               break;
            case 3:
               this.generatorThree.resetGeneratorTimer();
         }
      }
      
      public function setShieldEndgame() : void
      {
         if(currentFrameLabel != FRAME_LABEL_SHIELD_ENDGAME)
         {
            gotoAndStop(FRAME_LABEL_SHIELD_ENDGAME);
         }
      }
      
      public function setShieldOffline() : void
      {
         if(currentFrameLabel != FRAME_LABEL_SHIELD_OFFLINE)
         {
            gotoAndStop(FRAME_LABEL_SHIELD_OFFLINE);
            this.shieldTimerTF.filters = SHIELD_TIMER_FILTER;
         }
      }
      
      public function setShieldOnline() : void
      {
         if(currentFrameLabel != FRAME_LABEL_SHIELD_ONLINE)
         {
            gotoAndStop(FRAME_LABEL_SHIELD_ONLINE);
         }
      }
      
      public function updateGeneratorTimer(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         if(currentFrameLabel != FRAME_LABEL_SHIELD_ONLINE)
         {
            return;
         }
         switch(param1)
         {
            case 1:
               this.generatorOne.updateCaptureTimer(param2,param3,param4,param5);
               break;
            case 2:
               this.generatorTwo.updateCaptureTimer(param2,param3,param4,param5);
               break;
            case 3:
               this.generatorThree.updateCaptureTimer(param2,param3,param4,param5);
         }
      }
      
      public function updateShieldDownTimer(param1:int) : void
      {
         this.shieldTimerTF.label = param1.toString();
      }
   }
}
