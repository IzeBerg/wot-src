package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ILobbyPageMeta extends IEventDispatcher
   {
       
      
      function moveSpaceS(param1:Number, param2:Number, param3:Number) : void;
      
      function getSubContainerTypesS() : Array;
      
      function notifyCursorOver3dSceneS(param1:Boolean) : void;
      
      function notifyCursorDraggingS(param1:Boolean) : void;
      
      function as_showHelpLayout() : void;
      
      function as_closeHelpLayout() : void;
      
      function as_switchLobbyDragging(param1:Boolean) : void;
      
      function as_showWaiting(param1:String, param2:Boolean, param3:Boolean) : void;
      
      function as_hideWaiting() : void;
      
      function as_setSubContainerItemsVisibility(param1:Boolean) : void;
      
      function as_hideMessengerBar(param1:Boolean) : void;
      
      function as_updateNYVisibility(param1:Boolean) : void;
   }
}
