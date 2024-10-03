package net.wg.white_tiger.gui.battle.views.wtPlayersPanel.comps
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import scaleform.gfx.TextFieldEx;
   
   public class BotListInfo extends BattleUIComponent
   {
      
      private static const FRAME_LABEL_ALLY:String = "ally";
      
      private static const FRAME_LABEL_ENEMY:String = "enemy";
       
      
      public var titleTF:TextField = null;
      
      public var infoIcon:BotListInfoIcon = null;
      
      public var deadTimerTF:TextField = null;
      
      public var deadTimerBg:MovieClip = null;
      
      public function BotListInfo()
      {
         super();
         TextFieldEx.setNoTranslate(this.titleTF,true);
      }
      
      override protected function onDispose() : void
      {
         this.titleTF = null;
         this.deadTimerTF = null;
         this.deadTimerBg = null;
         super.onDispose();
      }
      
      public function resetGeneratorCaptureTimer() : void
      {
         this.infoIcon.resetIconTimer();
      }
      
      public function setData(param1:int, param2:Boolean) : void
      {
         gotoAndStop(!!param2 ? FRAME_LABEL_ALLY : FRAME_LABEL_ENEMY);
         this.deadTimerTF.mouseEnabled = this.titleTF.mouseEnabled = this.deadTimerTF.selectable = this.titleTF.selectable = false;
         this.titleTF.type = TextFieldType.DYNAMIC;
         this.updateIconStatus();
         var _loc3_:String = "";
         switch(param1)
         {
            case 1:
               _loc3_ = "A";
               break;
            case 2:
               _loc3_ = "B";
               break;
            case 3:
               _loc3_ = "C";
         }
         this.titleTF.text = App.utils.locale.makeString(EVENT.PLAYERSPANEL_CAMPLABEL,{"index":_loc3_});
      }
      
      public function setIsDestroyed(param1:Boolean) : void
      {
         this.infoIcon.setIsDestroyed();
         this.showDeadTimer(param1);
      }
      
      public function updateGeneratorCaptureTimer(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.infoIcon.updateCaptureTimer(param1,param2,param3,param4);
      }
      
      public function updateGeneratorDownTime(param1:Number, param2:Number, param3:String) : void
      {
         this.deadTimerTF.text = param3;
      }
      
      public function updateIconStatus() : void
      {
         this.showDeadTimer(false);
         this.infoIcon.setIconOnline();
      }
      
      private function showDeadTimer(param1:Boolean) : void
      {
         this.deadTimerTF.alpha = !!param1 ? Number(1) : Number(0);
         this.deadTimerBg.alpha = !!param1 ? Number(1) : Number(0);
      }
   }
}
