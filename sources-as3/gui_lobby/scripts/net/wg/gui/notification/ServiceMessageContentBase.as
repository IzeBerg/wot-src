package net.wg.gui.notification
{
   import net.wg.gui.notification.vo.MessageInfoVO;
   import net.wg.gui.notification.vo.NotificationInfoVO;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class ServiceMessageContentBase extends UIComponentEx
   {
      
      private static const WIDTH:int = 288;
       
      
      protected var _isPopUp:Boolean = false;
      
      private var _data:NotificationInfoVO = null;
      
      public function ServiceMessageContentBase()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         super.onDispose();
      }
      
      public function get isPopUp() : Boolean
      {
         return this._isPopUp;
      }
      
      public function set isPopUp(param1:Boolean) : void
      {
         this._isPopUp = param1;
      }
      
      public function get data() : NotificationInfoVO
      {
         return this._data;
      }
      
      public function set data(param1:NotificationInfoVO) : void
      {
         if(param1 == this._data)
         {
            return;
         }
         this._data = param1;
         invalidateData();
      }
      
      override public function get width() : Number
      {
         return WIDTH;
      }
      
      protected function get messageInfo() : MessageInfoVO
      {
         return Boolean(this._data) ? this._data.messageVO : null;
      }
   }
}
