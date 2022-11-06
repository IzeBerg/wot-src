package net.wg.infrastructure.managers.pool
{
   import net.wg.data.constants.Errors;
   import net.wg.utils.IAssertable;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ComponentsPool extends Pool
   {
       
      
      private var _linkage:String;
      
      private var _instanceClass:Class;
      
      public function ComponentsPool(param1:uint, param2:String, param3:Class)
      {
         var _loc4_:IAssertable = App.utils.asserter;
         _loc4_.assert(StringUtils.isNotEmpty(param2),"Tooltip block linkage" + Errors.CANT_EMPTY);
         this._linkage = param2;
         _loc4_.assert(param3 != null,"Instance class" + Errors.CANT_NULL);
         this._instanceClass = param3;
         super(param1,this.createBlock);
      }
      
      override protected function onDispose() : void
      {
         this._instanceClass = null;
         super.onDispose();
      }
      
      private function createBlock() : *
      {
         return App.utils.classFactory.getComponent(this._linkage,this._instanceClass);
      }
   }
}
