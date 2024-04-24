package net.wg.gui.lobby.quests.data.seasonAwards
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class IconTitleDescSeasonAwardVO extends DAAPIDataClass
   {
       
      
      public var iconPath:String = "";
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var tooltip:String = "";
      
      public function IconTitleDescSeasonAwardVO(param1:Object)
      {
         super(param1);
      }
   }
}
