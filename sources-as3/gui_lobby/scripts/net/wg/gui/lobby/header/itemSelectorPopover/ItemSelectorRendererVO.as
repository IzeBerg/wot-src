package net.wg.gui.lobby.header.itemSelectorPopover
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ItemSelectorRendererVO extends DAAPIDataClass
   {
       
      
      public var label:String = "";
      
      public var tooltip:String = "";
      
      public var data:String = "";
      
      public var disabled:Boolean;
      
      public var description:String = "";
      
      public var icon:String = "";
      
      public var active:Boolean;
      
      public var isNew:Boolean;
      
      public var specialBgIcon:String = "";
      
      public function ItemSelectorRendererVO(param1:Object)
      {
         super(param1);
      }
   }
}
