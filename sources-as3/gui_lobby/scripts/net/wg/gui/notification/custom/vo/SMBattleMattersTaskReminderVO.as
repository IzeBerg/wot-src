package net.wg.gui.notification.custom.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SMBattleMattersTaskReminderVO extends DAAPIDataClass
   {
       
      
      public var questIndex:int = 0;
      
      public function SMBattleMattersTaskReminderVO(param1:Object = null)
      {
         super(param1);
      }
      
      public function get questIndexStr() : String
      {
         return this.questIndex.toString();
      }
   }
}
