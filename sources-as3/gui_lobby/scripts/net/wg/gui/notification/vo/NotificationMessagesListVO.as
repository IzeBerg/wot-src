package net.wg.gui.notification.vo
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class NotificationMessagesListVO extends DAAPIDataClass
   {
      
      private static const MESSAGES_FIELD_NAME:String = "messages";
       
      
      public var messages:DataProvider;
      
      public var emptyListText:String = "";
      
      public var btnBarSelectedIdx:int = 0;
      
      public function NotificationMessagesListVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == MESSAGES_FIELD_NAME)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,param1 + Errors.CANT_NULL);
            this.messages = new DataProvider();
            for each(_loc4_ in _loc3_)
            {
               this.messages.push(new NotificationInfoVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this.messages)
         {
            _loc1_.dispose();
         }
         this.messages.cleanUp();
         this.messages = null;
         super.onDispose();
      }
   }
}
