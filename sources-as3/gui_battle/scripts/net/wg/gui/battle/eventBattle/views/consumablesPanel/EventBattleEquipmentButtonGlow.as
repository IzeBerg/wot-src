package net.wg.gui.battle.eventBattle.views.consumablesPanel
{
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.battle.views.consumablesPanel.BattleEquipmentButtonGlow;
   
   public class EventBattleEquipmentButtonGlow extends BattleEquipmentButtonGlow
   {
      
      private static const SHOW_GLOW_YELLOW_STATE:String = "yellow";
      
      private static const SHOW_GLOW_HIDE_STATE:String = "hide";
      
      private static const SHOW_GLOW_IDLE_STATE:String = "idle";
      
      private static const SHOW_GLOW_TIMEOUT_STATE:String = "timeout";
      
      private static const SHOW_GLOW_HIDETEXT_STATE:String = "hideText";
      
      private static const SHOW_GLOW_HIDEBACK_STATE:String = "hideBack";
      
      private static const READY_TEXT_COLOR:uint = 13434726;
      
      private static const TEXT_PADDING:int = 6;
      
      private static const TX_BACK_WIDTH:int = 25;
      
      private static const TX_BACK_POSITION:int = 23;
      
      private static const TEXT_MIN_WIDTH:int = 13;
       
      
      public var txBack:Sprite = null;
      
      public function EventBattleEquipmentButtonGlow()
      {
         super();
      }
      
      override public function hideGlow(param1:Boolean = true) : void
      {
         if(currentLabel == SHOW_GLOW_YELLOW_STATE)
         {
            gotoAndPlay(SHOW_GLOW_HIDE_STATE);
            if(_baseDisposed)
            {
               return;
            }
            bindKeyField.textColor = NORMAL_TEXT_COLOR;
         }
         else if(currentLabel == SHOW_GLOW_HIDETEXT_STATE)
         {
            gotoAndPlay(SHOW_GLOW_HIDEBACK_STATE);
            if(_baseDisposed)
            {
               return;
            }
            bindKeyField.textColor = NORMAL_TEXT_COLOR;
         }
         else if(currentLabel == SHOW_GLOW_TIMEOUT_STATE || currentLabel == SHOW_GLOW_ORANGE_STATE)
         {
            gotoAndStop(SHOW_GLOW_IDLE_STATE);
            if(_baseDisposed)
            {
               return;
            }
            bindKeyField.textColor = NORMAL_TEXT_COLOR;
         }
      }
      
      override public function setBindKeyText(param1:String) : void
      {
         super.setBindKeyText(param1);
         bindKeyField.autoSize = TextFieldAutoSize.CENTER;
         var _loc2_:int = bindKeyField.textWidth;
         var _loc3_:int = _loc2_ - TEXT_MIN_WIDTH;
         if(_loc3_ > 0)
         {
            this.txBack.x = TX_BACK_POSITION - (_loc3_ >> 1);
            this.txBack.width = TX_BACK_WIDTH + _loc3_;
         }
         else
         {
            this.txBack.x = TX_BACK_POSITION;
            this.txBack.width = TX_BACK_WIDTH;
         }
      }
      
      override protected function onDispose() : void
      {
         this.txBack = null;
         super.onDispose();
      }
      
      public function glowYellow() : void
      {
         if(currentLabel != SHOW_GLOW_YELLOW_STATE && currentLabel != SHOW_GLOW_TIMEOUT_STATE)
         {
            this.txBack.visible = true;
            gotoAndPlay(SHOW_GLOW_YELLOW_STATE);
            if(_baseDisposed)
            {
               return;
            }
            bindKeyField.textColor = READY_TEXT_COLOR;
         }
      }
      
      public function hideOnTimeout() : void
      {
         if(currentLabel == SHOW_GLOW_YELLOW_STATE)
         {
            gotoAndPlay(SHOW_GLOW_TIMEOUT_STATE);
            if(_baseDisposed)
            {
               return;
            }
            bindKeyField.textColor = NORMAL_TEXT_COLOR;
         }
      }
      
      public function hideText() : void
      {
         if(currentLabel == SHOW_GLOW_YELLOW_STATE)
         {
            gotoAndPlay(SHOW_GLOW_HIDETEXT_STATE);
            if(_baseDisposed)
            {
               return;
            }
            bindKeyField.textColor = NORMAL_TEXT_COLOR;
         }
      }
      
      public function hideTFContainer() : void
      {
         tfContainer.visible = false;
      }
   }
}
