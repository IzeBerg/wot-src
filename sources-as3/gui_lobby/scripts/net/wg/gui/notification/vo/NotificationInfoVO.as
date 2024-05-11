package net.wg.gui.notification.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class NotificationInfoVO extends DAAPIDataClass
   {
       
      
      public var typeID:uint = 0;
      
      public var entityID:Number = 0;
      
      public var message:Object;
      
      public var notify:Boolean;
      
      private var _messageVO:MessageInfoVO;
      
      public function NotificationInfoVO(param1:Object)
      {
         super(param1);
      }
      
      override public function isEquals(param1:DAAPIDataClass) : Boolean
      {
         var _loc2_:NotificationInfoVO = param1 as NotificationInfoVO;
         if(!_loc2_)
         {
            return false;
         }
         return _loc2_ && this.typeID == _loc2_.typeID && this.entityID == _loc2_.entityID;
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == "message")
         {
            this._messageVO = new MessageInfoVO(param2);
            return false;
         }
         return this.hasOwnProperty(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this._messageVO)
         {
            this._messageVO.dispose();
            this._messageVO = null;
         }
         super.onDispose();
      }
      
      public function get messageVO() : MessageInfoVO
      {
         return this._messageVO;
      }
   }
}
