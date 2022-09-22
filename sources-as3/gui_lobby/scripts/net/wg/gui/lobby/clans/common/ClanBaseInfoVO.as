package net.wg.gui.lobby.clans.common
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ClanBaseInfoVO extends DAAPIDataClass
   {
       
      
      public var name:String = "";
      
      public var bgIcon:String = "";
      
      public var creationDate:String = "";
      
      public function ClanBaseInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
