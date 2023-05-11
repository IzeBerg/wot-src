package net.wg.gui.lobby.hangar.tcarousel.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MultiselectionInfoVO extends DAAPIDataClass
   {
       
      
      public var statusSrt:String = "";
      
      public var vehicleTypes:String = "";
      
      public var formattedMessage:String = "";
      
      public var indicatorIsEnabled:Boolean = false;
      
      public var showSlots:Boolean = false;
      
      public function MultiselectionInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
