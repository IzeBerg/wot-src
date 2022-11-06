package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   
   public class TmenXpPanelMeta extends BaseDAAPIComponent
   {
       
      
      public var accelerateTmenXp:Function;
      
      public function TmenXpPanelMeta()
      {
         super();
      }
      
      public function accelerateTmenXpS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.accelerateTmenXp,"accelerateTmenXp" + Errors.CANT_NULL);
         this.accelerateTmenXp(param1);
      }
   }
}
