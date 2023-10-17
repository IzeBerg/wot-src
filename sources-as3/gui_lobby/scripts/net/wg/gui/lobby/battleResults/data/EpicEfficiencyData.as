package net.wg.gui.lobby.battleResults.data
{
   import flash.events.EventDispatcher;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class EpicEfficiencyData extends EventDispatcher implements IDisposable
   {
       
      
      public var name:String = "";
      
      public var count:String = "";
      
      public var iconUrl:String = "";
      
      private var _disposed:Boolean = false;
      
      public function EpicEfficiencyData(param1:String = "", param2:String = "", param3:String = "")
      {
         super();
         this.name = param1;
         this.count = param2;
         this.iconUrl = param3;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.name = null;
         this.count = null;
         this.iconUrl = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
