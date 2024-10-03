package net.wg.gui.lobby.components.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class AbilityBlockVO extends DAAPIDataClass
   {
       
      
      public var abilityName:String = "";
      
      public var tooltip:String = "";
      
      public var tooltipArgs:Array = null;
      
      public function AbilityBlockVO(param1:Object)
      {
         super(param1);
      }
   }
}
