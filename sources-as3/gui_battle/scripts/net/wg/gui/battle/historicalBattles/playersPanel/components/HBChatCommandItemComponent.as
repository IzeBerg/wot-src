package net.wg.gui.battle.historicalBattles.playersPanel.components
{
   import net.wg.gui.battle.components.stats.playersPanel.ChatCommandItemComponent;
   
   public class HBChatCommandItemComponent extends ChatCommandItemComponent
   {
      
      private static const HB_COMMAND_NAME_TO_FRAME_STATE:Object = {"attackBoss":15};
       
      
      public function HBChatCommandItemComponent()
      {
         super();
      }
      
      override protected function getActiveChatCommandFrame(param1:String) : int
      {
         var _loc2_:int = 0;
         if(HB_COMMAND_NAME_TO_FRAME_STATE.hasOwnProperty(param1))
         {
            _loc2_ = HB_COMMAND_NAME_TO_FRAME_STATE[param1];
         }
         else
         {
            _loc2_ = super.getActiveChatCommandFrame(param1);
         }
         return _loc2_;
      }
   }
}
