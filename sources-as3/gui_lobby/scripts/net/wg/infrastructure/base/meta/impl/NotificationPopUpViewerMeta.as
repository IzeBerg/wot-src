package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.notification.vo.PopUpNotificationInfoVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class NotificationPopUpViewerMeta extends BaseDAAPIComponent
   {
       
      
      public var setListClear:Function;
      
      public var onMessageHidden:Function;
      
      public var onClickAction:Function;
      
      public var getMessageActualTime:Function;
      
      public function NotificationPopUpViewerMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
      }
      
      public function setListClearS() : void
      {
         App.utils.asserter.assertNotNull(this.setListClear,"setListClear" + Errors.CANT_NULL);
         this.setListClear();
      }
      
      public function onMessageHiddenS(param1:Boolean, param2:Boolean, param3:int, param4:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onMessageHidden,"onMessageHidden" + Errors.CANT_NULL);
         this.onMessageHidden(param1,param2,param3,param4);
      }
      
      public function onClickActionS(param1:uint, param2:Number, param3:String) : void
      {
         App.utils.asserter.assertNotNull(this.onClickAction,"onClickAction" + Errors.CANT_NULL);
         this.onClickAction(param1,param2,param3);
      }
      
      public function getMessageActualTimeS(param1:Number) : String
      {
         App.utils.asserter.assertNotNull(this.getMessageActualTime,"getMessageActualTime" + Errors.CANT_NULL);
         return this.getMessageActualTime(param1);
      }
      
      public final function as_appendMessage(param1:Object) : void
      {
         var _loc2_:PopUpNotificationInfoVO = new PopUpNotificationInfoVO(param1);
         this.appendMessage(_loc2_);
      }
      
      public final function as_updateMessage(param1:Object) : void
      {
         var _loc2_:PopUpNotificationInfoVO = new PopUpNotificationInfoVO(param1);
         this.updateMessage(_loc2_);
      }
      
      protected function appendMessage(param1:PopUpNotificationInfoVO) : void
      {
         var _loc2_:String = "as_appendMessage" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateMessage(param1:PopUpNotificationInfoVO) : void
      {
         var _loc2_:String = "as_updateMessage" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
