package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   
   public class MinimapGridMeta extends BaseDAAPIComponent
   {
       
      
      public var setClick:Function;
      
      public function MinimapGridMeta()
      {
         super();
      }
      
      public function setClickS(param1:Number, param2:Number) : void
      {
         App.utils.asserter.assertNotNull(this.setClick,"setClick" + Errors.CANT_NULL);
         this.setClick(param1,param2);
      }
   }
}
