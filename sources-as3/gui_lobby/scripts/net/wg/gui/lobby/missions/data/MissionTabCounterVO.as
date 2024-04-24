package net.wg.gui.lobby.missions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MissionTabCounterVO extends DAAPIDataClass
   {
       
      
      public var linkage:String = "";
      
      public var value:int = 0;
      
      public var label:String = "";
      
      public var prefix:String = "";
      
      public function MissionTabCounterVO(param1:Object)
      {
         super(param1);
      }
   }
}
