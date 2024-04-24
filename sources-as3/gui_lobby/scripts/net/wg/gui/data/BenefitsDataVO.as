package net.wg.gui.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.techtree.data.vo.BenefitRendererVO;
   import scaleform.clik.data.DataProvider;
   
   public class BenefitsDataVO extends DAAPIDataClass
   {
      
      private static const BENEFITS_DATA:String = "benefitsData";
       
      
      public var benefitsData:DataProvider = null;
      
      public function BenefitsDataVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         switch(param1)
         {
            case BENEFITS_DATA:
               this.benefitsData = new DataProvider();
               if(param2)
               {
                  _loc3_ = param2 as Array;
                  App.utils.asserter.assertNotNull(_loc3_,"Wrong type of benefitsData");
                  for each(_loc4_ in _loc3_)
                  {
                     this.benefitsData.push(new BenefitRendererVO(_loc4_));
                  }
               }
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:BenefitRendererVO = null;
         if(this.benefitsData != null)
         {
            for each(_loc1_ in this.benefitsData)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
            this.benefitsData.length = 0;
            this.benefitsData = null;
         }
         super.onDispose();
      }
   }
}
