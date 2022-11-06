package net.wg.gui.tutorial.windows
{
   import flash.display.InteractiveObject;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.tutorial.controls.BattleBonusItem;
   import net.wg.gui.tutorial.data.BonusItemVO;
   import net.wg.gui.tutorial.data.BonusValuesVO;
   import scaleform.gfx.TextFieldEx;
   
   public class TutorialGreetingDialog extends TutorialDialog
   {
       
      
      public var imageLoader:UILoaderAlt;
      
      public var bonusItem:BattleBonusItem;
      
      public var timeField:TextField;
      
      public var restartHintField:TextField;
      
      public function TutorialGreetingDialog()
      {
         super();
      }
      
      override protected function drawData() : void
      {
         this.imageLoader.source = _data.imageUrl;
         this.timeField.htmlText = _data.timeNoteValue;
         messageField.htmlText = _data.message;
         TextFieldEx.setVerticalAlign(messageField,TextFieldAutoSize.CENTER);
         this.updateBonuses();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.restartHintField.text = App.utils.locale.makeString(BATTLE_TUTORIAL.DIALOGS_GREETING_RESTART_HINT_TEXT);
         TextFieldEx.setVerticalAlign(this.restartHintField,TextFieldAutoSize.CENTER);
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(submitBtn);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         window.useBottomBtns = true;
         window.title = BATTLE_TUTORIAL.DIALOGS_GREETING_TITLE;
      }
      
      override protected function onDispose() : void
      {
         this.imageLoader.dispose();
         this.imageLoader = null;
         this.bonusItem.dispose();
         this.bonusItem = null;
         this.timeField = null;
         this.restartHintField = null;
         super.onDispose();
      }
      
      private function updateBonuses() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:BonusItemVO = null;
         var _loc7_:BonusValuesVO = null;
         var _loc1_:Vector.<BonusItemVO> = Boolean(_data) ? _data.bonuses : null;
         if(this.bonusItem && _loc1_)
         {
            _loc2_ = 0;
            _loc3_ = 0;
            _loc4_ = _loc1_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = _loc1_[_loc5_];
               if(!_loc6_.received)
               {
                  _loc7_ = _loc6_.values;
                  if(_loc7_.credits)
                  {
                     _loc2_ += Number(_loc7_.credits);
                  }
                  if(_loc7_.freeXP)
                  {
                     _loc3_ += Number(_loc7_.freeXP);
                  }
               }
               _loc5_++;
            }
            this.bonusItem.setBonuses(_loc2_,_loc3_);
         }
      }
   }
}
