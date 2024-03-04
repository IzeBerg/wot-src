package net.wg.gui.battle.views.epicMessagesPanel.components
{
   import flash.display.MovieClip;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.GAME_MESSAGES_CONSTS;
   import net.wg.gui.battle.views.epicMessagesPanel.data.SectorBaseMessageVO;
   import net.wg.gui.battle.views.gameMessagesPanel.components.MessageContainerBase;
   import net.wg.gui.battle.views.gameMessagesPanel.data.GameMessageVO;
   import net.wg.gui.battle.views.gameMessagesPanel.events.GameMessagesPanelEvent;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class BaseCaptureMessage extends MessageContainerBase
   {
      
      private static const ERROR_CONVERTING_VO:String = "[BaseCaptureMessage] setData object was not in correct structure, could not convert to proper VO";
       
      
      public var mainTextMc:MovieClip = null;
      
      public var descriptionTextMc:MovieClip = null;
      
      public var timerTextMc:MovieClip = null;
      
      public var baseID:MovieClip = null;
      
      private var _msgDataVO:SectorBaseMessageVO = null;
      
      public function BaseCaptureMessage()
      {
         super();
         this.mainTextMc.titleTF.autoSize = TextFieldAutoSize.CENTER;
         this.timerTextMc.titleTF.autoSize = TextFieldAutoSize.CENTER;
         this.descriptionTextMc.tf.autoSize = TextFieldAutoSize.CENTER;
      }
      
      override public function getID() : int
      {
         return this._msgDataVO.baseID;
      }
      
      override public function getModificator() : String
      {
         var _loc1_:SectorBaseMessageVO = messageData.msgData as SectorBaseMessageVO;
         return !!StringUtils.isNotEmpty(_loc1_.descriptionText) ? GAME_MESSAGES_CONSTS.WITH_UNLOCK : super.getModificator();
      }
      
      override public function setData(param1:GameMessageVO) : void
      {
         var _loc2_:SectorBaseMessageVO = null;
         messageData = param1;
         _loc2_ = param1.msgData as SectorBaseMessageVO;
         App.utils.asserter.assertNotNull(_loc2_,ERROR_CONVERTING_VO);
         this._msgDataVO = _loc2_;
         this.baseID.gotoAndStop(_loc2_.baseID);
         this.mainTextMc.titleTF.text = _loc2_.title;
         this.timerTextMc.titleTF.text = _loc2_.timerText;
         this.descriptionTextMc.visible = StringUtils.isNotEmpty(_loc2_.descriptionText);
         this.descriptionTextMc.tf.text = _loc2_.descriptionText;
         this.descriptionTextMc.line.width = this.descriptionTextMc.width;
      }
      
      override protected function getPostIntroGameMessagesPanelEvent() : GameMessagesPanelEvent
      {
         var _loc1_:GameMessagesPanelEvent = super.getPostIntroGameMessagesPanelEvent();
         _loc1_.messageModificator = GAME_MESSAGES_CONSTS.WITH_ADD_TIME;
         return _loc1_;
      }
      
      override protected function onDispose() : void
      {
         this.baseID = null;
         this.mainTextMc = null;
         this.descriptionTextMc = null;
         this.timerTextMc = null;
         this._msgDataVO = null;
         super.onDispose();
      }
   }
}
