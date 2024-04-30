package net.wg.gui.battle.historicalBattles.gameMessagesPanel.components
{
   import net.wg.gui.battle.views.epicMessagesPanel.data.SectorBaseMessageVO;
   import net.wg.gui.battle.views.gameMessagesPanel.components.EndGameMessageTextfields;
   import net.wg.gui.battle.views.gameMessagesPanel.components.MessageContainerBase;
   import net.wg.gui.battle.views.gameMessagesPanel.data.GameMessageVO;
   
   public class ObjectiveGameMessage extends MessageContainerBase
   {
       
      
      public var textfields:EndGameMessageTextfields = null;
      
      private var _msgDataVO:SectorBaseMessageVO = null;
      
      public function ObjectiveGameMessage()
      {
         super();
      }
      
      public function layoutMessage(param1:Function) : void
      {
         param1(this.textfields.titleTF);
      }
      
      override public function getID() : int
      {
         return this._msgDataVO.baseID;
      }
      
      override public function getMsgHeight() : int
      {
         return this.textfields.height;
      }
      
      override public function setData(param1:GameMessageVO) : void
      {
         messageData = param1;
         var _loc2_:SectorBaseMessageVO = param1.msgData as SectorBaseMessageVO;
         this.textfields.titleTF.text = _loc2_.title;
         this.textfields.subtitleTF.text = _loc2_.descriptionText;
         this._msgDataVO = _loc2_;
      }
      
      override protected function onDispose() : void
      {
         this.textfields.dispose();
         this.textfields = null;
         this._msgDataVO = null;
         super.onDispose();
      }
   }
}
