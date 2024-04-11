package net.wg.gui.battle.historicalBattles.messenger
{
   import net.wg.gui.battle.views.battleMessenger.BattleMessage;
   import net.wg.infrastructure.base.meta.IHBBattleMessengerMeta;
   import net.wg.infrastructure.base.meta.impl.HBBattleMessengerMeta;
   
   public class HBBattleMessenger extends HBBattleMessengerMeta implements IHBBattleMessengerMeta
   {
       
      
      private var _isReadingMode:Boolean = false;
      
      public function HBBattleMessenger()
      {
         super();
      }
      
      override public function as_enterPressed(param1:int) : void
      {
         if(this._isReadingMode)
         {
            return;
         }
         super.as_enterPressed(param1);
      }
      
      override public function as_toggleCtrlPressFlag(param1:Boolean) : void
      {
         if(this._isReadingMode)
         {
            return;
         }
         super.as_toggleCtrlPressFlag(param1);
      }
      
      public function as_toggleReadingModer(param1:Boolean) : void
      {
         var _loc2_:BattleMessage = null;
         var _loc3_:int = 0;
         if(isCtrlButtonPressed)
         {
            this.as_toggleCtrlPressFlag(false);
         }
         this._isReadingMode = param1;
         receiverField.visible = itemBackground.visible = !param1;
         hit.mouseEnabled = !this._isReadingMode;
         if(this._isReadingMode)
         {
            for each(_loc2_ in messages)
            {
               _loc3_ = _loc2_.getState();
               if(_loc3_ == BattleMessage.STATE_RECOVERED_MES)
               {
                  _loc2_.setState(BattleMessage.STATE_VISIBLE_MES);
               }
            }
            setPanelElementsVisibility(false);
         }
         else
         {
            for each(_loc2_ in messages)
            {
               _loc3_ = _loc2_.getState();
               if(_loc3_ == BattleMessage.STATE_VISIBLE_MES)
               {
                  _loc2_.setState(BattleMessage.STATE_RECOVERED_MES);
               }
            }
         }
      }
   }
}
