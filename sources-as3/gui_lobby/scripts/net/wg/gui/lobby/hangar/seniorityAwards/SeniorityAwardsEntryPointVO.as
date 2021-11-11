package net.wg.gui.lobby.hangar.seniorityAwards
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SeniorityAwardsEntryPointVO extends DAAPIDataClass
   {
       
      
      public var count:String = "";
      
      public var descr:String = "";
      
      public var btnLabel:String = "";
      
      public var multiplier:String = "";
      
      public function SeniorityAwardsEntryPointVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
