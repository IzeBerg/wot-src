package net.wg.gui.lobby.settings.vo
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class VisitedCounters implements IDisposable
   {
       
      
      private var _viewId:String = null;
      
      private var _subViewId:String = null;
      
      private var _ids:Array = null;
      
      private var _disposed:Boolean = false;
      
      public function VisitedCounters(param1:String, param2:String, param3:Array)
      {
         super();
         this._viewId = param1;
         this._ids = param3;
         this._subViewId = param2;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         if(this._ids)
         {
            this._ids.splice(0,this._ids.length);
            this._ids = null;
         }
      }
      
      public function get viewId() : String
      {
         return this._viewId;
      }
      
      public function get subViewId() : String
      {
         return this._subViewId;
      }
      
      public function get ids() : Array
      {
         return this._ids;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
