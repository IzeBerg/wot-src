package net.wg.gui.lobby.missions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MissionsTankVO extends DAAPIDataClass
   {
       
      
      public var id:int = -1;
      
      public var iconSmall:String = "";
      
      public var label:String = "";
      
      public var level:Number = 0;
      
      public var premium:Boolean = false;
      
      public var nation:Number = 0;
      
      public var tankType:String = "";
      
      public function MissionsTankVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
