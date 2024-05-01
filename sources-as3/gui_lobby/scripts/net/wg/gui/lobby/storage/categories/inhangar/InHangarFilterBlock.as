package net.wg.gui.lobby.storage.categories.inhangar
{
   import net.wg.data.Aliases;
   import net.wg.data.constants.AlignType;
   import net.wg.gui.lobby.storage.categories.StorageVehicleFilterBlock;
   import scaleform.clik.constants.InvalidationType;
   
   public class InHangarFilterBlock extends StorageVehicleFilterBlock
   {
       
      
      public function InHangarFilterBlock()
      {
         super();
         filterCounter.contentAlign = AlignType.LEFT;
      }
      
      override protected function get filterPopoverAlias() : String
      {
         return Aliases.STORAGE_VEHICLES_FILTER_POPOVER;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            filterCounter.x = filterTitle.x + filterTitle.width + filterNameGap;
         }
      }
   }
}
