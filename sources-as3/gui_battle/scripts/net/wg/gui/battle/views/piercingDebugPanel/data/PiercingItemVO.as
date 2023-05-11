package net.wg.gui.battle.views.piercingDebugPanel.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PiercingItemVO extends DAAPIDataClass
   {
       
      
      public var vehiclePart:String = "";
      
      public var angle:String = "";
      
      public var piercingPowerLeft:String = "";
      
      public var piercingPercent:String = "";
      
      public var armor:String = "";
      
      public var penetrationArmor:String = "";
      
      public var result:String = "";
      
      public function PiercingItemVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
