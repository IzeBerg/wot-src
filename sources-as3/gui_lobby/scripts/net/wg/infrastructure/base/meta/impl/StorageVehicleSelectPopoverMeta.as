package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.storage.categories.storage.vehicleSelectPopover.StorageVehicleSelectPopoverVO;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class StorageVehicleSelectPopoverMeta extends SmartPopOverView
   {
       
      
      public var setVehicleSelected:Function;
      
      public var applyFilters:Function;
      
      public var changeSearchNameVehicle:Function;
      
      private var _storageVehicleSelectPopoverVO:StorageVehicleSelectPopoverVO;
      
      public function StorageVehicleSelectPopoverMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._storageVehicleSelectPopoverVO)
         {
            this._storageVehicleSelectPopoverVO.dispose();
            this._storageVehicleSelectPopoverVO = null;
         }
         super.onDispose();
      }
      
      public function setVehicleSelectedS(param1:int, param2:Boolean = false) : void
      {
         App.utils.asserter.assertNotNull(this.setVehicleSelected,"setVehicleSelected" + Errors.CANT_NULL);
         this.setVehicleSelected(param1,param2);
      }
      
      public function applyFiltersS(param1:int, param2:String, param3:int, param4:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.applyFilters,"applyFilters" + Errors.CANT_NULL);
         this.applyFilters(param1,param2,param3,param4);
      }
      
      public function changeSearchNameVehicleS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.changeSearchNameVehicle,"changeSearchNameVehicle" + Errors.CANT_NULL);
         this.changeSearchNameVehicle(param1);
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:StorageVehicleSelectPopoverVO = this._storageVehicleSelectPopoverVO;
         this._storageVehicleSelectPopoverVO = new StorageVehicleSelectPopoverVO(param1);
         this.setInitData(this._storageVehicleSelectPopoverVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInitData(param1:StorageVehicleSelectPopoverVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
