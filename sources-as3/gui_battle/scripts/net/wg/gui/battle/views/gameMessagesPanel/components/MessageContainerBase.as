package net.wg.gui.battle.views.gameMessagesPanel.components
{
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.GAME_MESSAGES_CONSTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.gameMessagesPanel.data.GameMessageVO;
   import net.wg.gui.battle.views.gameMessagesPanel.events.GameMessagesPanelEvent;
   import net.wg.gui.utils.FrameHelper;
   
   public class MessageContainerBase extends BattleUIComponent
   {
      
      private static const POST_INTRO_LABEL:String = "postIntro";
      
      private static const OUTRO_LABEL:String = "outro";
       
      
      protected var messageData:GameMessageVO = null;
      
      private var _frameHelper:FrameHelper = null;
      
      public function MessageContainerBase()
      {
         super();
         this._frameHelper = new FrameHelper(this);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._frameHelper.addScriptToFrame(this._frameHelper.getFrameByLabel(POST_INTRO_LABEL),this.onPostIntroAnimationStart);
         this._frameHelper.addScriptToFrame(this._frameHelper.getFrameByLabel(OUTRO_LABEL),this.onOutroAnimationStart);
      }
      
      override protected function onDispose() : void
      {
         this.messageData = null;
         this._frameHelper.dispose();
         this._frameHelper = null;
         super.onDispose();
      }
      
      public function getID() : int
      {
         return -1;
      }
      
      public function getModificator() : String
      {
         return Values.EMPTY_STR;
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
      
      protected function getPostIntroGameMessagesPanelEvent() : GameMessagesPanelEvent
      {
         var _loc1_:GameMessagesPanelEvent = new GameMessagesPanelEvent(GameMessagesPanelEvent.MESSAGES_POST_INTRO_PLAYING,this.messageData.messageType);
         _loc1_.messageId = this.getID();
         return _loc1_;
      }
      
      private function onPostIntroAnimationStart() : void
      {
         dispatchEvent(this.getPostIntroGameMessagesPanelEvent());
      }
      
      private function onOutroAnimationStart() : void
      {
         var _loc1_:GameMessagesPanelEvent = new GameMessagesPanelEvent(GameMessagesPanelEvent.MESSAGES_OUTRO_PLAYING,this.messageData.messageType);
         _loc1_.messageId = this.getID();
         _loc1_.messageModificator = GAME_MESSAGES_CONSTS.WITH_HIDE;
         dispatchEvent(_loc1_);
      }
   }
}
