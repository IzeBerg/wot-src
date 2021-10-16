package net.wg.gui.battle.views.epicMessagesPanel.components
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.views.gameMessagesPanel.components.MessageContainerBase;
   import net.wg.gui.battle.views.gameMessagesPanel.data.BaseGameMessageVO;
   import net.wg.gui.battle.views.gameMessagesPanel.data.GameMessageVO;
   
   public class RetreatMessage extends MessageContainerBase
   {
      
      private static const ERROR_CONVERTING_VO:String = "[RetreatMessage] setData object was not in correct structure, could not convert to proper VO";
       
      
      public var mainTextMc:MovieClip = null;
      
      private var _msgDataVO:BaseGameMessageVO = null;
      
      public function RetreatMessage()
      {
         super();
      }
      
      override public function setData(param1:GameMessageVO) : void
      {
         messageData = param1;
         var _loc2_:BaseGameMessageVO = param1.msgData as BaseGameMessageVO;
         App.utils.asserter.assertNotNull(_loc2_,ERROR_CONVERTING_VO);
         this._msgDataVO = _loc2_;
         this.mainTextMc.titleTF.text = _loc2_.title;
      }
      
      override protected function onDispose() : void
      {
         this.mainTextMc = null;
         this._msgDataVO = null;
         super.onDispose();
      }
   }
}
