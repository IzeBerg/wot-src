package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBCMessageWindowMeta extends IEventDispatcher
   {
       
      
      function onMessageRemovedS() : void;
      
      function onMessageAppearS(param1:String) : void;
      
      function onMessageDisappearS(param1:String, param2:String) : void;
      
      function onMessageExecutedS(param1:String) : void;
      
      function onMessageButtonClickedS() : void;
      
      function onMessageAnimationStoppedS(param1:String) : void;
      
      function onMessageAnimationStartedS(param1:String) : void;
      
      function hideBlurS() : void;
      
      function as_setMessageData(param1:Array) : void;
      
      function as_blurOtherWindows(param1:int) : void;
   }
}
