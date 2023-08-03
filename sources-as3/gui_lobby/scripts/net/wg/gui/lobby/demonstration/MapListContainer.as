package net.wg.gui.lobby.demonstration
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.TileList;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class MapListContainer extends UIComponentEx
   {
      
      private static const COL_COUNT:int = 5;
       
      
      public var label:TextField;
      
      public var mapList:TileList = null;
      
      public function MapListContainer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.label.text = MENU.DEMONSTRATOR_MAPS_LABEL;
         this.mapList.addEventListener(ListEvent.ITEM_CLICK,this.onMapListItemClickHandler);
         this.mapList.width = this.mapList.columnWidth * COL_COUNT + this.mapList.padding.right * (COL_COUNT - 1);
      }
      
      override protected function onDispose() : void
      {
         this.mapList.removeEventListener(ListEvent.ITEM_CLICK,this.onMapListItemClickHandler);
         this.mapList.dispose();
         this.mapList = null;
         this.label = null;
         super.onDispose();
      }
      
      public function setListHeight(param1:int = 1) : void
      {
         var _loc2_:int = Math.ceil(param1 / COL_COUNT);
         var _loc3_:int = this.mapList.rowHeight * _loc2_;
         var _loc4_:int = this.mapList.padding.bottom * _loc2_ + this.mapList.padding.top;
         height = this.mapList.height = _loc3_ + _loc4_;
      }
      
      public function set dataProvider(param1:IDataProvider) : void
      {
         this.mapList.dataProvider = param1;
         this.mapList.selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         this.mapList.selectedIndex = param1;
      }
      
      private function onMapListItemClickHandler(param1:ListEvent) : void
      {
         dispatchEvent(param1);
      }
   }
}
