package net.wg.gui.lobby.missions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MissionHeaderActionVO extends DAAPIDataClass
   {
       
      
      public var actionID:String = "";
      
      public var label:String = "";
      
      public var visible:Boolean;
      
      public function MissionHeaderActionVO(param1:Object)
      {
         super(param1);
      }
   }
}
