package net.wg.gui.data
{
   import net.wg.data.VO.AwardsItemVO;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BaseAwardsBlockVO extends DAAPIDataClass
   {
      
      private static const AWARDS:String = "awards";
       
      
      public var awards:Vector.<AwardsItemVO> = null;
      
      public function BaseAwardsBlockVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == AWARDS && param2 != null)
         {
            this.awards = Vector.<AwardsItemVO>(App.utils.data.convertVOArrayToVector(param1,param2,AwardsItemVO));
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:AwardsItemVO = null;
         if(this.awards != null)
         {
            for each(_loc1_ in this.awards)
            {
               _loc1_.dispose();
            }
            this.awards.fixed = false;
            this.awards.splice(0,this.awards.length);
            this.awards = null;
         }
         super.onDispose();
      }
   }
}
