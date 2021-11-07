package net.wg.gui.battle.eventBattle.views.eventStats.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EventBuffsVO extends DAAPIDataClass
   {
       
      
      public var name:String = "";
      
      public var description:String = "";
      
      public var imageName:String = "";
      
      public function EventBuffsVO(param1:Object)
      {
         super(param1);
      }
   }
}
