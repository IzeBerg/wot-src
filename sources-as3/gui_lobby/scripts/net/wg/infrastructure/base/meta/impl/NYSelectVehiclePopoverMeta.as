package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.ny2020.vo.NYSelectVehiclePopoverVO;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class NYSelectVehiclePopoverMeta extends SmartPopOverView
   {
       
      
      public var onSelectVehicle:Function;
      
      public var applyFilters:Function;
      
      private var _nYSelectVehiclePopoverVO:NYSelectVehiclePopoverVO;
      
      public function NYSelectVehiclePopoverMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._nYSelectVehiclePopoverVO)
         {
            this._nYSelectVehiclePopoverVO.dispose();
            this._nYSelectVehiclePopoverVO = null;
         }
         super.onDispose();
      }
      
      public function onSelectVehicleS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onSelectVehicle,"onSelectVehicle" + Errors.CANT_NULL);
         this.onSelectVehicle(param1);
      }
      
      public function applyFiltersS(param1:int, param2:String, param3:int) : void
      {
         App.utils.asserter.assertNotNull(this.applyFilters,"applyFilters" + Errors.CANT_NULL);
         this.applyFilters(param1,param2,param3);
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:NYSelectVehiclePopoverVO = this._nYSelectVehiclePopoverVO;
         this._nYSelectVehiclePopoverVO = new NYSelectVehiclePopoverVO(param1);
         this.setInitData(this._nYSelectVehiclePopoverVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInitData(param1:NYSelectVehiclePopoverVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
