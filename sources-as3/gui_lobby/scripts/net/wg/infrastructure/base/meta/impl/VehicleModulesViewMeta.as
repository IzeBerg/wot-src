package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehicleCompare.VehicleCompareConfiguratorBaseView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class VehicleModulesViewMeta extends VehicleCompareConfiguratorBaseView
   {
       
      
      public var onModuleHover:Function;
      
      public var onModuleClick:Function;
      
      private var _array:Array;
      
      public function VehicleModulesViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._array)
         {
            this._array.splice(0,this._array.length);
            this._array = null;
         }
         super.onDispose();
      }
      
      public function onModuleHoverS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onModuleHover,"onModuleHover" + Errors.CANT_NULL);
         this.onModuleHover(param1);
      }
      
      public function onModuleClickS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onModuleClick,"onModuleClick" + Errors.CANT_NULL);
         this.onModuleClick(param1);
      }
      
      public final function as_setNodesStates(param1:Array) : void
      {
         var _loc2_:Array = this._array;
         this._array = param1;
         this.setNodesStates(this._array);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setNodesStates(param1:Array) : void
      {
         var _loc2_:String = "as_setNodesStates" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
