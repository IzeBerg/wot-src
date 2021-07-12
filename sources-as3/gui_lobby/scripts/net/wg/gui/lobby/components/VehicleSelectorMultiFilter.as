package net.wg.gui.lobby.components
{
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.components.interfaces.IVehicleSelectorFilter;
   import net.wg.gui.lobby.components.data.VehicleSelectorMultiFilterVO;
   import net.wg.gui.lobby.components.interfaces.IVehicleSelectorFilterVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class VehicleSelectorMultiFilter extends UIComponentEx implements IVehicleSelectorFilter
   {
       
      
      public var toggles:SimpleTileList = null;
      
      protected var initData:VehicleSelectorMultiFilterVO;
      
      public function VehicleSelectorMultiFilter()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.toggles.dispose();
         this.toggles = null;
         this.initData = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.initData && isInvalid(InvalidationType.DATA))
         {
            this.toggles.dataProvider = this.initData.togglesDP;
            invalidateSize();
         }
      }
      
      public function setData(param1:IVehicleSelectorFilterVO) : void
      {
         this.initData = VehicleSelectorMultiFilterVO(param1);
         invalidate(InvalidationType.DATA);
      }
   }
}
