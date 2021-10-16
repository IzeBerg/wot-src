package net.wg.data.VO.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DAAPIVehiclesUserTagsVO extends DAAPIDataClass
   {
       
      
      public var leftUserTags:Vector.<DAAPIVehicleUserTagsVO> = null;
      
      public var rightUserTags:Vector.<DAAPIVehicleUserTagsVO> = null;
      
      private const COND_ALLY_FIELD_NAME:String = "leftItems";
      
      private const COND_ENEMY_FIELD_NAME:String = "rightItems";
      
      public function DAAPIVehiclesUserTagsVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case this.COND_ALLY_FIELD_NAME:
               this.leftUserTags = Vector.<DAAPIVehicleUserTagsVO>(App.utils.data.convertVOArrayToVector(param1,param2,DAAPIVehicleUserTagsVO));
               return false;
            case this.COND_ENEMY_FIELD_NAME:
               this.rightUserTags = Vector.<DAAPIVehicleUserTagsVO>(App.utils.data.convertVOArrayToVector(param1,param2,DAAPIVehicleUserTagsVO));
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:DAAPIVehicleUserTagsVO = null;
         if(this.leftUserTags)
         {
            for each(_loc1_ in this.leftUserTags)
            {
               _loc1_.dispose();
            }
            this.leftUserTags.fixed = false;
            this.leftUserTags.splice(0,this.leftUserTags.length);
            this.leftUserTags = null;
         }
         if(this.rightUserTags)
         {
            for each(_loc1_ in this.rightUserTags)
            {
               _loc1_.dispose();
            }
            this.rightUserTags.fixed = false;
            this.rightUserTags.splice(0,this.rightUserTags.length);
            this.rightUserTags = null;
         }
         super.onDispose();
      }
   }
}
