package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehiclePreview.infoPanel.crew.VPCrewTabVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class VehiclePreviewCrewTabMeta extends BaseDAAPIComponent
   {
       
      
      public var setActiveState:Function;
      
      public var getTooltipData:Function;
      
      private var _vPCrewTabVO:VPCrewTabVO;
      
      public function VehiclePreviewCrewTabMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vPCrewTabVO)
         {
            this._vPCrewTabVO.dispose();
            this._vPCrewTabVO = null;
         }
         super.onDispose();
      }
      
      public function setActiveStateS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setActiveState,"setActiveState" + Errors.CANT_NULL);
         this.setActiveState(param1);
      }
      
      public function getTooltipDataS(param1:int, param2:int) : Array
      {
         App.utils.asserter.assertNotNull(this.getTooltipData,"getTooltipData" + Errors.CANT_NULL);
         return this.getTooltipData(param1,param2);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:VPCrewTabVO = this._vPCrewTabVO;
         this._vPCrewTabVO = new VPCrewTabVO(param1);
         this.setData(this._vPCrewTabVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:VPCrewTabVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
