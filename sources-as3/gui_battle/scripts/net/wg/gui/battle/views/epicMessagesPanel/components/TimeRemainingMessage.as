package net.wg.gui.battle.views.epicMessagesPanel.components
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.views.gameMessagesPanel.components.MessageContainerBase;
   import net.wg.gui.battle.views.gameMessagesPanel.data.BaseGameMessageVO;
   import net.wg.gui.battle.views.gameMessagesPanel.data.GameMessageVO;
   
   public class TimeRemainingMessage extends MessageContainerBase
   {
      
      private static const ERROR_CONVERTING_VO:String = "[TimeRemainingMessage] setData object was not in correct structure, could not convert to proper VO";
       
      
      public var mainTextMc:MovieClip = null;
      
      public function TimeRemainingMessage()
      {
         super();
      }
      
      override public function setData(param1:GameMessageVO) : void
      {
         messageData = param1;
         var _loc2_:BaseGameMessageVO = param1.msgData as BaseGameMessageVO;
         App.utils.asserter.assertNotNull(_loc2_,ERROR_CONVERTING_VO);
         this.mainTextMc.titleTF.text = _loc2_.title;
      }
      
      override protected function onDispose() : void
      {
         this.mainTextMc = null;
         super.onDispose();
      }
   }
}
