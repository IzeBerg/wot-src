package net.wg.gui.battle.views.epicMessagesPanel.components
{
   import flash.display.MovieClip;
   import net.wg.data.constants.generated.GAME_MESSAGES_CONSTS;
   import net.wg.gui.battle.views.epicMessagesPanel.data.HeadquarterAttackedMessageVO;
   import net.wg.gui.battle.views.gameMessagesPanel.components.MessageContainerBase;
   import net.wg.gui.battle.views.gameMessagesPanel.data.GameMessageVO;
   
   public class HeadquarterAttackedMessage extends MessageContainerBase
   {
      
      private static const MAX_FRAME_HQ_ANIMATION:int = 101;
      
      private static const HQ_GREEN_STATE:String = "green";
      
      private static const HQ_RED_STATE:String = "red";
      
      private static const ERROR_CONVERTING_VO:String = "[HeadquarterAttackedMessage] setData object was not in correct structure, could not convert to proper VO";
       
      
      public var mainTextMc:MovieClip = null;
      
      public var hqMarker:MessageHQMarker = null;
      
      private var _msgDataVO:HeadquarterAttackedMessageVO = null;
      
      public function HeadquarterAttackedMessage()
      {
         super();
      }
      
      override public function getID() : int
      {
         return this._msgDataVO.hqID;
      }
      
      override public function setData(param1:GameMessageVO) : void
      {
         messageData = param1;
         var _loc2_:HeadquarterAttackedMessageVO = param1.msgData as HeadquarterAttackedMessageVO;
         App.utils.asserter.assertNotNull(_loc2_,ERROR_CONVERTING_VO);
         this._msgDataVO = _loc2_;
         this.mainTextMc.titleTF.text = _loc2_.title;
         this.hqMarker.epicHQId.gotoAndStop(_loc2_.hqID);
         this.hqMarker.gotoAndStop(param1.messageType == GAME_MESSAGES_CONSTS.OBJECTIVE_UNDER_ATTACK_POSITIVE ? HQ_GREEN_STATE : HQ_RED_STATE);
         this.hqMarker.hqProgress.gotoAndStop(MAX_FRAME_HQ_ANIMATION - (_loc2_.destroyedProgress * MAX_FRAME_HQ_ANIMATION >> 0));
      }
      
      override protected function onDispose() : void
      {
         this.mainTextMc = null;
         this.hqMarker.dispose();
         this.hqMarker = null;
         this._msgDataVO = null;
         super.onDispose();
      }
   }
}
