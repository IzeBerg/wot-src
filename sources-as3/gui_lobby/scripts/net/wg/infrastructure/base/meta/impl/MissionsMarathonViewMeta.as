package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   
   public class MissionsMarathonViewMeta extends BaseDAAPIComponent
   {
       
      
      public var viewSize:Function;
      
      public function MissionsMarathonViewMeta()
      {
         super();
      }
      
      public function viewSizeS(param1:Number, param2:Number) : void
      {
         App.utils.asserter.assertNotNull(this.viewSize,"viewSize" + Errors.CANT_NULL);
         this.viewSize(param1,param2);
      }
   }
}
