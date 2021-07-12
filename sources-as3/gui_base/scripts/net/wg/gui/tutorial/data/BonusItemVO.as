package net.wg.gui.tutorial.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BonusItemVO extends DAAPIDataClass
   {
      
      private static const VALUES_FIELD_NAME:String = "values";
       
      
      public var received:Boolean = false;
      
      public var values:BonusValuesVO;
      
      public function BonusItemVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == VALUES_FIELD_NAME)
         {
            this.values = new BonusValuesVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.values != null)
         {
            this.values.dispose();
            this.values = null;
         }
         super.onDispose();
      }
   }
}
