package net.wg.gui.lobby.profile.pages.awards.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class AchievementFilterVO extends DAAPIDataClass
   {
       
      
      public var dataProvider:Array;
      
      public var selectedItem:String = "";
      
      public function AchievementFilterVO(param1:Object)
      {
         super(param1);
      }
   }
}
