package net.wg.utils.scheduler
{
   import net.wg.infrastructure.interfaces.entity.ICallable;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class Task implements ICallable, IDisposable
   {
       
      
      private var _handler:Function = null;
      
      private var _args:Array = null;
      
      private var _disposed:Boolean = false;
      
      public function Task(param1:Function, param2:Array)
      {
         super();
         this._handler = param1;
         this._args = param2;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this._handler = null;
         this._args.splice(0,this._args.length);
         this._args = null;
      }
      
      public function invoke() : void
      {
         if(this._args.length > 0)
         {
            this._handler.apply(null,this._args);
         }
         else
         {
            this._handler();
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function get handler() : Function
      {
         return this._handler;
      }
   }
}
