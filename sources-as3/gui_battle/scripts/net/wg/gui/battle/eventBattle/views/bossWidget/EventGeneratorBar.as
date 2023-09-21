package net.wg.gui.battle.eventBattle.views.bossWidget
{
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.components.EventGeneratorProgressCircle;
   import net.wg.gui.components.controls.TextFieldContainer;
   
   public class EventGeneratorBar extends BattleUIComponent
   {
      
      private static const FRAME_LABEL_SHIELD_ONLINE:String = "shieldOnline";
      
      private static const FRAME_LABEL_SHIELD_OFFLINE:String = "shieldOffline";
      
      private static const FRAME_LABEL_SHIELD_ENDGAME:String = "shieldEndgame";
      
      private static const SHIELD_TIMER_FILTER:Array = [new DropShadowFilter(0,0,16711680,1,2,2,2,BitmapFilterQuality.HIGH)];
       
      
      public var generatorOne:EventGeneratorProgressCircle = null;
      
      public var generatorTwo:EventGeneratorProgressCircle = null;
      
      public var generatorThree:EventGeneratorProgressCircle = null;
      
      public var shieldTimerTF:TextFieldContainer = null;
      
      public function EventGeneratorBar()
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
               this.generatorOne.resetGenerator();
               break;
            case 2:
               this.generatorTwo.resetGenerator();
               break;
            case 3:
               this.generatorThree.resetGenerator();
         }
      }
      
      public function updateShieldDownTimer(param1:Number) : void
      {
         var _loc2_:String = int(param1).toString();
         this.shieldTimerTF.label = _loc2_;
      }
      
      public function updateGeneratorTimer(param1:Number, param2:Number) : void
      {
         if(currentFrameLabel != FRAME_LABEL_SHIELD_ONLINE)
         {
            return;
         }
         switch(param1)
         {
            case 1:
               this.generatorOne.updateProgress(param2);
               break;
            case 2:
               this.generatorTwo.updateProgress(param2);
               break;
            case 3:
               this.generatorThree.updateProgress(param2);
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
      
      public function setShieldEndgame() : void
      {
         if(currentFrameLabel != FRAME_LABEL_SHIELD_ENDGAME)
         {
            gotoAndStop(FRAME_LABEL_SHIELD_ENDGAME);
         }
      }
   }
}
