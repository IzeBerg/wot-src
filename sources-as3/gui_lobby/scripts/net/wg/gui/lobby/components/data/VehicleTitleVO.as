package net.wg.gui.lobby.components.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleTitleVO extends DAAPIDataClass
   {
       
      
      public var tankTierStr:String = "";
      
      public var tankNameStr:String = "";
      
      public var tankTierStrSmall:String = "";
      
      public var tankNameStrSmall:String = "";
      
      public var typeIconPath:String = "";
      
      public var isElite:Boolean = false;
      
      public var statusStr:String = "";
      
      public var intCD:uint = 0;
      
      public var roleText:String = "";
      
      public var showInfoIcon:Boolean = true;
      
      public function VehicleTitleVO(param1:Object)
      {
         super(param1);
      }
   }
}
