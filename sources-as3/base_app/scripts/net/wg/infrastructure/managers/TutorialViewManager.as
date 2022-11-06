package net.wg.infrastructure.managers
{
   import flash.display.DisplayObject;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class TutorialViewManager extends EventDispatcher implements ITutorialViewManager
   {
       
      
      private var _disposed:Boolean = false;
      
      public function TutorialViewManager(param1:IEventDispatcher = null)
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
      }
      
      public function hideHint(param1:DisplayObject) : void
      {
         param1.alpha = 1;
      }
      
      public function showHint(param1:DisplayObject, param2:Array) : void
      {
         param1.alpha = 0.5;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
