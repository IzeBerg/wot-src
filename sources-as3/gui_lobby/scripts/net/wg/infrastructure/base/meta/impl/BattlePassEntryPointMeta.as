package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   
   public class BattlePassEntryPointMeta extends GFInjectComponent
   {
       
      
      public var setIsSmall:Function;
      
      public function BattlePassEntryPointMeta()
      {
         super();
      }
      
      public function setIsSmallS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setIsSmall,"setIsSmall" + Errors.CANT_NULL);
         this.setIsSmall(param1);
      }
   }
}
