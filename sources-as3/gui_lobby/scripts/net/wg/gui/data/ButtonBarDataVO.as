package net.wg.gui.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ButtonBarDataVO extends DAAPIDataClass
   {
      
      private static const ITEMS_FIELD_NAME:String = "buttonBarItems";
       
      
      public var buttonBarItems:Array = null;
      
      public function ButtonBarDataVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == ITEMS_FIELD_NAME)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,_loc3_ + Errors.CANT_NULL);
            this.buttonBarItems = [];
            for each(_loc4_ in param2)
            {
               this.buttonBarItems.push(new ButtonBarItemVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.buttonBarItems != null)
         {
            for each(_loc1_ in this.buttonBarItems)
            {
               _loc1_.dispose();
            }
            this.buttonBarItems.splice(0,this.buttonBarItems.length);
            this.buttonBarItems = null;
         }
         super.onDispose();
      }
   }
}
