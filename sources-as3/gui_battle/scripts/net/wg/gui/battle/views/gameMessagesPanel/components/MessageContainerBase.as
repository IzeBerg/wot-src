package net.wg.gui.battle.views.gameMessagesPanel.components
{
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.gameMessagesPanel.data.GameMessageVO;
   
   public class MessageContainerBase extends BattleUIComponent
   {
       
      
      protected var messageData:GameMessageVO = null;
      
      public function MessageContainerBase()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.messageData = null;
         super.onDispose();
      }
      
      public function getID() : int
      {
         return -1;
      }
      
      public function getMsgHeight() : int
      {
         return height;
      }
      
      public function getType() : String
      {
         return this.messageData.messageType;
      }
      
      public function setData(param1:GameMessageVO) : void
      {
         this.messageData = param1;
      }
   }
}
