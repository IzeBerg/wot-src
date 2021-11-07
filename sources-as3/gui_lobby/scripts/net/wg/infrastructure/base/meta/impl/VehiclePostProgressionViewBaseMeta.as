package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.components.data.VehicleTitleVO;
   import net.wg.gui.lobby.vehPostProgression.data.VehPostProgressionViewVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class VehiclePostProgressionViewBaseMeta extends AbstractView
   {
       
      
      public var demountAllPairs:Function;
      
      private var _vehicleTitleVO:VehicleTitleVO;
      
      private var _vehPostProgressionViewVO:VehPostProgressionViewVO;
      
      public function VehiclePostProgressionViewBaseMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vehicleTitleVO)
         {
            this._vehicleTitleVO.dispose();
            this._vehicleTitleVO = null;
         }
         if(this._vehPostProgressionViewVO)
         {
            this._vehPostProgressionViewVO.dispose();
            this._vehPostProgressionViewVO = null;
         }
         super.onDispose();
      }
      
      public function demountAllPairsS() : void
      {
         App.utils.asserter.assertNotNull(this.demountAllPairs,"demountAllPairs" + Errors.CANT_NULL);
         this.demountAllPairs();
      }
      
      public final function as_setVehicleTitle(param1:Object) : void
      {
         var _loc2_:VehicleTitleVO = this._vehicleTitleVO;
         this._vehicleTitleVO = new VehicleTitleVO(param1);
         this.setVehicleTitle(this._vehicleTitleVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:VehPostProgressionViewVO = this._vehPostProgressionViewVO;
         this._vehPostProgressionViewVO = new VehPostProgressionViewVO(param1);
         this.setData(this._vehPostProgressionViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setVehicleTitle(param1:VehicleTitleVO) : void
      {
         var _loc2_:String = "as_setVehicleTitle" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setData(param1:VehPostProgressionViewVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
