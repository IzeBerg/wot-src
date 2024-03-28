package net.wg.infrastructure.interfaces
{
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import net.wg.data.daapi.LoadViewVO;
   
   public interface IView extends IDAAPIModule, IManagedContent, IUIComponentEx, ITutorialView
   {
       
      
      function getSubContainers() : Array;
      
      function playShowTween(param1:DisplayObject, param2:Function = null) : Boolean;
      
      function playHideTween(param1:DisplayObject, param2:Function = null) : Boolean;
      
      function leaveModalFocus() : void;
      
      function setModalFocus() : void;
      
      function setViewSize(param1:Number, param2:Number) : void;
      
      function updateStage(param1:Number, param2:Number) : void;
      
      function get as_config() : LoadViewVO;
      
      function set as_config(param1:LoadViewVO) : void;
      
      function get loader() : Loader;
      
      function set loader(param1:Loader) : void;
   }
}
