package net.wg.gui.battle.ranked.stats.components.fullStats
{
   import net.wg.gui.battle.TabbedFullStats;
   import net.wg.gui.battle.interfaces.IReservesStats;
   import net.wg.gui.battle.interfaces.ITabbedFullStatsTableController;
   import net.wg.gui.battle.views.personalReservesTab.PersonalReservesTab;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   
   public class FullStats extends TabbedFullStats implements IReservesStats
   {
      
      private static const LEFT_SIDE_TEXT_SMALL_Y_SHIFT:int = 31;
      
      private static const TAB_RESERVES_Y_SHIFT:int = 13;
       
      
      public var tabReserves:PersonalReservesTab = null;
      
      private var _tableCtrl:FullStatsTableCtrl = null;
      
      public function FullStats()
      {
         super();
      }
      
      override public function getTableCtrl() : ITabbedFullStatsTableController
      {
         this._tableCtrl = new FullStatsTableCtrl(FullStatsTable(statsTable));
         return this._tableCtrl;
      }
      
      override public function updateStageSize(param1:Number, param2:Number) : void
      {
         super.updateStageSize(param1,param2);
         if(this.tabReserves)
         {
            this.tabReserves.width = param1;
            this.tabReserves.height = param2 - this.tabReserves.y;
            this.tabReserves.x = -this.tabReserves.width >> 1;
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         header.setLeftSideSmallYShift(LEFT_SIDE_TEXT_SMALL_Y_SHIFT);
      }
      
      override protected function doUpdateSizeTable(param1:Number, param2:Number) : void
      {
         super.doUpdateSizeTable(param1,param2);
         if(this.tabReserves != null)
         {
            this.tabReserves.y = tabs.y + TAB_RESERVES_Y_SHIFT;
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.tabReserves != null)
         {
            this.tabReserves = null;
         }
         this._tableCtrl = null;
         super.onDispose();
      }
      
      override protected function setTitle() : void
      {
         if(statsTable.visible)
         {
            super.setTitle();
         }
         else if(this.tabReserves && this.tabReserves.visible)
         {
            title.setTitle(App.utils.locale.makeString(INGAME_GUI.STATISTICS_TAB_PERSONALRESERVES_HEADER_TITLE));
         }
      }
      
      override protected function updateCurrentTab() : void
      {
         var _loc2_:Boolean = false;
         statsTable.visible = tabs.selectedIndex == 0;
         var _loc1_:Boolean = tabs.selectedIndex == 1;
         if(this.tabReserves != null)
         {
            this.tabReserves.visible = _loc1_;
         }
         _loc2_ = statsTable.visible || _loc1_;
         title.visible = _loc2_ && !_loc1_;
         if(_loc2_)
         {
            this.setTitle();
         }
      }
      
      public function getReservesView() : IDAAPIModule
      {
         return this.tabReserves;
      }
   }
}
