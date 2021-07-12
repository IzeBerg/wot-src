package net.wg.gui.battle.views.gameMessagesPanel.components
{
   import net.wg.gui.battle.views.gameMessagesPanel.data.EndGameMessageVO;
   import net.wg.gui.battle.views.gameMessagesPanel.data.GameMessageVO;
   
   public class EndGameMessage extends MessageContainerBase
   {
      
      private static const ERROR_CONVERTING_VO:String = "[EndGameMessage] setData object was not in correct structure, could not convert to proper VO";
       
      
      public var textfields:EndGameMessageTextfields = null;
      
      private var _msgDataVO:EndGameMessageVO = null;
      
      public function EndGameMessage()
      {
         super();
      }
      
      override public function getID() : int
      {
         return this._msgDataVO.reason;
      }
      
      override public function getMsgHeight() : int
      {
         return this.textfields.height;
      }
      
      override public function setData(param1:GameMessageVO) : void
      {
         messageData = param1;
         var _loc2_:EndGameMessageVO = param1.msgData as EndGameMessageVO;
         App.utils.asserter.assertNotNull(_loc2_,ERROR_CONVERTING_VO);
         this.textfields.titleTF.text = _loc2_.title;
         this.textfields.subtitleTF.text = _loc2_.subTitle;
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
