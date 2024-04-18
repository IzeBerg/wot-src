package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class AdditionalAwardsVO extends DAAPIDataClass
   {
      
      private static const AWARDS_FIELD:String = "awards";
       
      
      public var title:String = "";
      
      public var awards:DataProvider = null;
      
      public function AdditionalAwardsVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == AWARDS_FIELD)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(param2 is Array,Errors.INVALID_TYPE + "Array");
            this.awards = new DataProvider();
            for each(_loc4_ in _loc3_)
            {
               this.awards.push(new AwardItemRendererExVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.awards != null)
         {
            for each(_loc1_ in this.awards)
            {
               _loc1_.dispose();
            }
            this.awards.cleanUp();
            this.awards = null;
         }
         super.onDispose();
      }
   }
}
