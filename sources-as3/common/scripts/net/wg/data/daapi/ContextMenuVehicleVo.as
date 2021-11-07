package net.wg.data.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ContextMenuVehicleVo extends DAAPIDataClass
   {
       
      
      public var component:String = "";
      
      public var inventoryId:Number = -1;
      
      public var compactDescr:Number = 0;
      
      public var favorite:Boolean = false;
      
      public var canSell:Boolean = false;
      
      public var wasInBattle:Boolean = false;
      
      public var isRented:Boolean = false;
      
      public var rentalIsOver:Boolean = false;
      
      public var canBuyOrRent:Boolean = false;
      
      public var isPremiumIGR:Boolean = false;
      
      public function ContextMenuVehicleVo(param1:Object)
      {
         super(param1);
      }
   }
}
