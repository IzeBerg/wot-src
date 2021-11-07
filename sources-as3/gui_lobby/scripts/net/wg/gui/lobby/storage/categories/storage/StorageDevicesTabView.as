package net.wg.gui.lobby.storage.categories.storage
{
   import flash.events.Event;
   
   public class StorageDevicesTabView extends ItemsWithVehicleFilterTabView
   {
       
      
      public function StorageDevicesTabView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         noItemsView.addEventListener(Event.CLOSE,this.onNoItemViewCloseHandler);
      }
      
      override protected function initNoItemsView() : void
      {
         noItemsView.setTexts(STORAGE.STORAGE_NOITEMS_TITLE,STORAGE.STORAGE_NOITEMS_NAVIGATIONBUTTON);
      }
      
      override protected function doPartlyVisibility(param1:Boolean, param2:Boolean) : void
      {
         super.doPartlyVisibility(param1,param2);
         if(param2)
         {
            noItemsView.visible = false;
            filtersBlock.visible = true;
         }
      }
      
      override protected function onDispose() : void
      {
         noItemsView.removeEventListener(Event.CLOSE,this.onNoItemViewCloseHandler);
         super.onDispose();
      }
      
      private function onNoItemViewCloseHandler(param1:Event) : void
      {
         navigateToStoreS();
      }
   }
}
