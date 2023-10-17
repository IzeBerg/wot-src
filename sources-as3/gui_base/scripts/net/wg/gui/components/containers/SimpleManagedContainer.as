package net.wg.gui.components.containers
{
   import net.wg.data.constants.generated.LAYER_NAMES;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.ISimpleManagedContainer;
   
   public class SimpleManagedContainer extends UIComponentEx implements ISimpleManagedContainer
   {
       
      
      protected var _manageFocus:Boolean = true;
      
      private var _layer:int = -1;
      
      private var _manageSize:Boolean = true;
      
      public function SimpleManagedContainer(param1:String)
      {
         super();
         this._layer = LAYER_NAMES.LAYER_ORDER.indexOf(param1);
         name = param1;
         this._manageSize = false;
         mouseEnabled = false;
      }
      
      public function get layer() : int
      {
         return this._layer;
      }
      
      public function get layerName() : String
      {
         return name;
      }
      
      public function get manageFocus() : Boolean
      {
         return this._manageFocus;
      }
      
      public function get manageSize() : Boolean
      {
         return this._manageSize;
      }
      
      public function set manageSize(param1:Boolean) : void
      {
         this._manageSize = param1;
      }
   }
}
