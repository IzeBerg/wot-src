package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleMessengerMeta extends IEventDispatcher
   {
       
      
      function sendMessageToChannelS(param1:int, param2:String) : Boolean;
      
      function focusReceivedS() : void;
      
      function focusLostS() : void;
      
      function getToxicStatusS(param1:String) : Object;
      
      function onToxicButtonClickedS(param1:String, param2:Number) : void;
      
      function onToxicPanelClosedS(param1:String) : void;
      
      function as_enableToxicPanel() : void;
      
      function as_updateMessages(param1:String, param2:String) : void;
      
      function as_showGreenMessage(param1:String, param2:String) : void;
      
      function as_showRedMessage(param1:String, param2:String) : void;
      
      function as_showBlackMessage(param1:String, param2:String) : void;
      
      function as_showSelfMessage(param1:String, param2:String) : void;
      
      function as_setupList(param1:Object) : void;
      
      function as_setReceiver(param1:Object, param2:Boolean) : void;
      
      function as_changeReceiver(param1:int) : void;
      
      function as_setActive(param1:Boolean) : void;
      
      function as_setFocus() : void;
      
      function as_unSetFocus() : void;
      
      function as_setUserPreferences(param1:String) : void;
      
      function as_setReceivers(param1:Array) : void;
      
      function as_enableToSendMessage() : void;
      
      function as_toggleCtrlPressFlag(param1:Boolean) : void;
      
      function as_enterPressed(param1:int) : void;
      
      function as_updateToxicPanel(param1:String, param2:Object) : void;
      
      function as_restoreMessages(param1:String) : void;
   }
}
