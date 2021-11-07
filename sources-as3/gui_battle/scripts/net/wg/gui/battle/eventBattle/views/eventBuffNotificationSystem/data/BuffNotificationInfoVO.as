package net.wg.gui.battle.eventBattle.views.eventBuffNotificationSystem.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BuffNotificationInfoVO extends DAAPIDataClass
   {
       
      
      public var iconSource:String = "";
      
      public var title:String = "";
      
      public var timeDescription1:String = "";
      
      public var description1:String = "";
      
      public var timeDescription2:String = "";
      
      public var description2:String = "";
      
      public function BuffNotificationInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
