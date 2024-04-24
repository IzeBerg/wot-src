package net.wg.gui.lobby.battleResults
{
   import flash.display.InteractiveObject;
   import net.wg.gui.lobby.battleResults.components.DetailsStatsScrollPane;
   import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
   import net.wg.gui.lobby.battleResults.data.VehicleStatsVO;
   import net.wg.gui.lobby.battleResults.epic.EpicDetailsVehicleSelection;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.events.ListEvent;
   
   public class DetailsStatsView extends UIComponentEx implements IViewStackContent
   {
       
      
      public var epicVehicleSelection:EpicDetailsVehicleSelection = null;
      
      public var scrollPane:DetailsStatsScrollPane = null;
      
      private var _data:BattleResultsVO = null;
      
      public function DetailsStatsView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.epicVehicleSelection.addEventListener(ListEvent.INDEX_CHANGE,this.onSelectVehicleClickIndexChangeHandler);
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         this.epicVehicleSelection.removeEventListener(ListEvent.INDEX_CHANGE,this.onSelectVehicleClickIndexChangeHandler);
         this.epicVehicleSelection.dispose();
         this.epicVehicleSelection = null;
         this.scrollPane.dispose();
         this.scrollPane = null;
         super.onDispose();
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:Vector.<VehicleStatsVO> = null;
         this._data = BattleResultsVO(param1);
         this.epicVehicleSelection.visible = false;
         if(this._data.common.epicMode)
         {
            _loc2_ = this._data.common.playerVehicles;
            this.epicVehicleSelection.visible = true;
            this.epicVehicleSelection.setData(_loc2_,this._data.common.playerVehicleNames,this._data.selectedIdxInGarageDropdown);
            this.scrollPane.setOffsetY(this.epicVehicleSelection.height);
            this.scrollPane.isScrollBarHaveToBeShown = true;
         }
         else
         {
            this.scrollPane.setOffsetY(0);
         }
         this.scrollPane.detailsStats.setBattleResultsVO(this._data);
      }
      
      private function onSelectVehicleClickIndexChangeHandler(param1:ListEvent) : void
      {
         this._data.selectedIdxInGarageDropdown = param1.index;
         this.scrollPane.detailsStats.setSelectedVehicleIndex(param1.index);
      }
   }
}
