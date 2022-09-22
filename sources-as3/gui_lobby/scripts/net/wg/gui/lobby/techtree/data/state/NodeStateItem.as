package net.wg.gui.lobby.techtree.data.state
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class NodeStateItem implements IDisposable
   {
       
      
      private var _state:uint;
      
      private var _props:StateProperties;
      
      private var _disposed:Boolean = false;
      
      public function NodeStateItem(param1:uint, param2:StateProperties)
      {
         super();
         this._state = param1;
         this._props = param2;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function getState() : uint
      {
         return this._state;
      }
      
      public function resolveProps(param1:Object = null) : StateProperties
      {
         return this._props;
      }
      
      protected function onDispose() : void
      {
         if(this._props != null)
         {
            this._props.dispose();
            this._props = null;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
