package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.notification.vo.NotificationInfoVO;
   import net.wg.gui.notification.vo.NotificationMessagesListVO;
   import net.wg.gui.notification.vo.NotificationViewInitVO;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class NotificationsListMeta extends SmartPopOverView
   {
       
      
      public var onClickAction:Function;
      
      public var getMessageActualTime:Function;
      
      public var onGroupChange:Function;
      
      private var _notificationViewInitVO:NotificationViewInitVO;
      
      private var _notificationMessagesListVO:NotificationMessagesListVO;
      
      private var _array:Array;
      
      public function NotificationsListMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._notificationViewInitVO)
         {
            this._notificationViewInitVO.dispose();
            this._notificationViewInitVO = null;
         }
         if(this._notificationMessagesListVO)
         {
            this._notificationMessagesListVO.dispose();
            this._notificationMessagesListVO = null;
         }
         if(this._array)
         {
            this._array.splice(0,this._array.length);
            this._array = null;
         }
         super.onDispose();
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
      
      public function onGroupChangeS(param1:uint) : void
      {
         App.utils.asserter.assertNotNull(this.onGroupChange,"onGroupChange" + Errors.CANT_NULL);
         this.onGroupChange(param1);
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:NotificationViewInitVO = this._notificationViewInitVO;
         this._notificationViewInitVO = new NotificationViewInitVO(param1);
         this.setInitData(this._notificationViewInitVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setMessagesList(param1:Object) : void
      {
         var _loc2_:NotificationMessagesListVO = this._notificationMessagesListVO;
         this._notificationMessagesListVO = new NotificationMessagesListVO(param1);
         this.setMessagesList(this._notificationMessagesListVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_appendMessage(param1:Object) : void
      {
         var _loc2_:NotificationInfoVO = new NotificationInfoVO(param1);
         this.appendMessage(_loc2_);
      }
      
      public final function as_updateMessage(param1:Object) : void
      {
         var _loc2_:NotificationInfoVO = new NotificationInfoVO(param1);
         this.updateMessage(_loc2_);
      }
      
      public final function as_updateCounters(param1:Array) : void
      {
         var _loc2_:Array = this._array;
         this._array = param1;
         this.updateCounters(this._array);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setInitData(param1:NotificationViewInitVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setMessagesList(param1:NotificationMessagesListVO) : void
      {
         var _loc2_:String = "as_setMessagesList" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function appendMessage(param1:NotificationInfoVO) : void
      {
         var _loc2_:String = "as_appendMessage" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateMessage(param1:NotificationInfoVO) : void
      {
         var _loc2_:String = "as_updateMessage" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateCounters(param1:Array) : void
      {
         var _loc2_:String = "as_updateCounters" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
