package net.wg.data.VO.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DAAPIVehiclesInvitationStatusVO extends DAAPIDataClass
   {
       
      
      public var leftItems:Vector.<DAAPIInvitationStatusVO> = null;
      
      public var rightItems:Vector.<DAAPIInvitationStatusVO> = null;
      
      private const LEFT_FIELD_NAME:String = "leftItems";
      
      private const RIGHT_FIELD_NAME:String = "rightItems";
      
      public function DAAPIVehiclesInvitationStatusVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case this.LEFT_FIELD_NAME:
               this.leftItems = Vector.<DAAPIInvitationStatusVO>(App.utils.data.convertVOArrayToVector(param1,param2,DAAPIInvitationStatusVO));
               return false;
            case this.RIGHT_FIELD_NAME:
               this.rightItems = Vector.<DAAPIInvitationStatusVO>(App.utils.data.convertVOArrayToVector(param1,param2,DAAPIInvitationStatusVO));
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:DAAPIInvitationStatusVO = null;
         if(this.leftItems)
         {
            for each(_loc1_ in this.leftItems)
            {
               _loc1_.dispose();
            }
            this.leftItems.fixed = false;
            this.leftItems.splice(0,this.leftItems.length);
            this.leftItems = null;
         }
         if(this.rightItems)
         {
            for each(_loc1_ in this.rightItems)
            {
               _loc1_.dispose();
            }
            this.rightItems.fixed = false;
            this.rightItems.splice(0,this.rightItems.length);
            this.rightItems = null;
         }
         super.onDispose();
      }
   }
}
