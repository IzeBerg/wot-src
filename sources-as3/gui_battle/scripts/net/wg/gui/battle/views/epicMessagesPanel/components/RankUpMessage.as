package net.wg.gui.battle.views.epicMessagesPanel.components
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.views.epicMessagesPanel.data.RankUpMessageVO;
   import net.wg.gui.battle.views.gameMessagesPanel.components.MessageContainerBase;
   import net.wg.gui.battle.views.gameMessagesPanel.data.GameMessageVO;
   
   public class RankUpMessage extends MessageContainerBase
   {
      
      private static const ERROR_CONVERTING_VO:String = "[RankUpMessage] setData object was not in correct structure, could not convert to proper VO";
       
      
      public var mainTextMc:MovieClip = null;
      
      public var icon:MovieClip = null;
      
      public var rankUpSubMc:RankUpSubElement = null;
      
      private var _msgDataVO:RankUpMessageVO = null;
      
      public function RankUpMessage()
      {
         super();
      }
      
      override public function setData(param1:GameMessageVO) : void
      {
         messageData = param1;
         var _loc2_:RankUpMessageVO = param1.msgData as RankUpMessageVO;
         App.utils.asserter.assertNotNull(_loc2_,ERROR_CONVERTING_VO);
         this._msgDataVO = _loc2_;
         this.mainTextMc.titleTF.text = _loc2_.title;
         this.icon.gotoAndStop(_loc2_.rank);
         this.rankUpSubMc.setText(_loc2_.subTitle);
      }
      
      override protected function onDispose() : void
      {
         this.icon = null;
         this.mainTextMc = null;
         this._msgDataVO = null;
         this.rankUpSubMc.dispose();
         this.rankUpSubMc = null;
         super.onDispose();
      }
   }
}
