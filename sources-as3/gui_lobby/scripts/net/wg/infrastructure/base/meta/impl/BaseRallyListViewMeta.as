package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.rally.BaseRallyView;
   
   public class BaseRallyListViewMeta extends BaseRallyView
   {
       
      
      public var getRallyDetails:Function;
      
      public function BaseRallyListViewMeta()
      {
         super();
      }
      
      public function getRallyDetailsS(param1:int) : Object
      {
         App.utils.asserter.assertNotNull(this.getRallyDetails,"getRallyDetails" + Errors.CANT_NULL);
         return this.getRallyDetails(param1);
      }
   }
}
