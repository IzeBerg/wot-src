package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class InfoAdditionalBlockDataVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var image:String = "";
      
      public function InfoAdditionalBlockDataVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
