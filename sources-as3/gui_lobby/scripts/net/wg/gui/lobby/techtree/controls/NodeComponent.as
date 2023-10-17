package net.wg.gui.lobby.techtree.controls
{
   import net.wg.gui.lobby.techtree.interfaces.IHasRendererAsOwner;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class NodeComponent extends UIComponentEx implements IHasRendererAsOwner
   {
       
      
      protected var _owner:IRenderer = null;
      
      private var _state:String = "locked";
      
      public function NodeComponent()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this._owner = null;
         super.onDispose();
      }
      
      public function setOwner(param1:IRenderer, param2:Boolean = false) : void
      {
         if(this._owner != param1)
         {
            this._owner = param1;
         }
         invalidateData();
         if(param2)
         {
            validateNow();
         }
      }
      
      [Inspectable(defaultValue="locked",type="String",enumeration="locked,blueprint,normal,premium")]
      public function get state() : String
      {
         return this._state;
      }
      
      public function set state(param1:String) : void
      {
         if(this._state == param1)
         {
            return;
         }
         this._state = param1;
      }
   }
}
