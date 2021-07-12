package net.wg.gui.battle.views.messages.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MessageListSettingsVO extends DAAPIDataClass
   {
       
      
      public var direction:String = "up";
      
      public var messageGap:Number = 0.0;
      
      public function MessageListSettingsVO(param1:Object)
      {
         super(param1);
      }
   }
}
