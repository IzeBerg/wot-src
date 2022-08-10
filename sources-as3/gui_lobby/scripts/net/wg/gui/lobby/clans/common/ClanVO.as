package net.wg.gui.lobby.clans.common
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ClanVO extends DAAPIDataClass
   {
       
      
      public var dbID:Number = 0;
      
      public var fullName:String = "";
      
      public var clanName:String = "";
      
      public var clanAbbrev:String = "";
      
      public var isActive:Boolean = false;
      
      public var showIcon:Boolean = false;
      
      public var iconSource:String = "";
      
      public function ClanVO(param1:Object)
      {
         super(param1);
      }
   }
}
