package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.notification.vo.NotificationDialogInitInfoVO;
   import net.wg.gui.notification.vo.NotificationInfoVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class SystemMessageDialogMeta extends AbstractWindowView
   {
       
      
      private var _notificationDialogInitInfoVO:NotificationDialogInitInfoVO;
      
      private var _notificationInfoVO:NotificationInfoVO;
      
      public function SystemMessageDialogMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._notificationDialogInitInfoVO)
         {
            this._notificationDialogInitInfoVO.dispose();
            this._notificationDialogInitInfoVO = null;
         }
         if(this._notificationInfoVO)
         {
            this._notificationInfoVO.dispose();
            this._notificationInfoVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:NotificationDialogInitInfoVO = this._notificationDialogInitInfoVO;
         this._notificationDialogInitInfoVO = new NotificationDialogInitInfoVO(param1);
         this.setInitData(this._notificationDialogInitInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setMessageData(param1:Object) : void
      {
         var _loc2_:NotificationInfoVO = this._notificationInfoVO;
         this._notificationInfoVO = new NotificationInfoVO(param1);
         this.setMessageData(this._notificationInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInitData(param1:NotificationDialogInitInfoVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setMessageData(param1:NotificationInfoVO) : void
      {
         var _loc2_:String = "as_setMessageData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
