package net.wg.gui.lobby.storage.categories.personalreserves
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class StorageCategoryPersonalReservesVO extends DAAPIDataClass
   {
       
      
      public var activeText:String = "";
      
      public var hasActiveReserve:Boolean;
      
      public function StorageCategoryPersonalReservesVO(param1:Object)
      {
         super(param1);
      }
   }
}
