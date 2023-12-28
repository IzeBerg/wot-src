package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PMAwardHeaderVO extends DAAPIDataClass
   {
       
      
      public var level:String = "";
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var vehIcon:String = "";
      
      public function PMAwardHeaderVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
