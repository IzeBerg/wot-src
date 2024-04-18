package net.wg.gui.lobby.battleResults.epic
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.TileList;
   import net.wg.gui.lobby.battleResults.data.VehicleItemVO;
   import net.wg.gui.lobby.battleResults.data.VehicleStatsVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.data.DataProvider;
   
   public class EpicDetailsVehicleSelection extends UIComponentEx
   {
       
      
      public var vehicleSelectionList:TileList = null;
      
      public function EpicDetailsVehicleSelection()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.vehicleSelectionList.scrollBar = Linkages.SCROLL_BAR;
         this.vehicleSelectionList.itemRenderer = App.utils.classFactory.getClass(Linkages.EPIC_BATTLE_RESULTS_VEHICLE_RENDERER);
         this.vehicleSelectionList.direction = DirectionMode.HORIZONTAL;
      }
      
      override protected function onDispose() : void
      {
         this.vehicleSelectionList.dispose();
         this.vehicleSelectionList = null;
         super.onDispose();
      }
      
      public function setData(param1:Vector.<VehicleStatsVO>, param2:Array, param3:int) : void
      {
         var _loc7_:Object = null;
         var _loc4_:Array = [];
         var _loc5_:int = param1.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = {};
            _loc7_.label = param2[_loc6_];
            _loc7_.flag = param1[_loc6_].flag;
            _loc7_.icon = param1[_loc6_].tankIcon;
            _loc4_.push(new VehicleItemVO(_loc7_));
            _loc6_++;
         }
         if(_loc4_.length > 0)
         {
            this.vehicleSelectionList.visible = true;
            if(this.vehicleSelectionList.dataProvider)
            {
               this.vehicleSelectionList.dataProvider.cleanUp();
            }
            this.vehicleSelectionList.dataProvider = new DataProvider(_loc4_);
            this.vehicleSelectionList.selectedIndex = param3;
         }
      }
   }
}
