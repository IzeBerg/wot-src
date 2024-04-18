package net.wg.gui.lobby.header.itemSelectorPopover
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ItemSelectorTooltipDataVO extends DAAPIDataClass
   {
       
      
      public var tooltip:String = "";
      
      public var isSpecial:Boolean = false;
      
      public var isWulf:Boolean = false;
      
      public function ItemSelectorTooltipDataVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
