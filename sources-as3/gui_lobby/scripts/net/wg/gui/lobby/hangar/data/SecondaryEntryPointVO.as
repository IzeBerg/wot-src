package net.wg.gui.lobby.hangar.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SecondaryEntryPointVO extends DAAPIDataClass
   {
       
      
      public var flagIcon:String = "";
      
      public var icon:String = "";
      
      public var altIcon:String = "";
      
      public var text:String = "";
      
      public var tooltip:String = "";
      
      public var tooltipType:String = "";
      
      public var isEnabled:Boolean = true;
      
      public var isBought:Boolean = true;
      
      public var is3DStyleChosen:Boolean = true;
      
      public function SecondaryEntryPointVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
