package net.wg.gui.battle.views.epicMessagesPanel.components
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.views.epicMessagesPanel.data.FirstGeneralRankReachedMessageVO;
   import net.wg.gui.battle.views.gameMessagesPanel.components.MessageContainerBase;
   import net.wg.gui.battle.views.gameMessagesPanel.data.GameMessageVO;
   
   public class FirstGeneralRankReachedMessage extends MessageContainerBase
   {
      
      private static const ERROR_CONVERTING_VO:String = "[FirstGeneralRankReachedMessage] setData object was not in correct structure, could not convert to proper VO";
       
      
      public var mainTextMc:MovieClip = null;
      
      private var _msgDataVO:FirstGeneralRankReachedMessageVO = null;
      
      public function FirstGeneralRankReachedMessage()
      {
         super();
      }
      
      override public function setData(param1:GameMessageVO) : void
      {
         messageData = param1;
         var _loc2_:FirstGeneralRankReachedMessageVO = param1.msgData as FirstGeneralRankReachedMessageVO;
         App.utils.asserter.assertNotNull(_loc2_,ERROR_CONVERTING_VO);
         this._msgDataVO = _loc2_;
         this.mainTextMc.titleTF.text = _loc2_.title;
         this.mainTextMc.subtitleTF.text = _loc2_.subTitle;
      }
      
      override protected function onDispose() : void
      {
         this.mainTextMc = null;
         this._msgDataVO = null;
         super.onDispose();
      }
   }
}
