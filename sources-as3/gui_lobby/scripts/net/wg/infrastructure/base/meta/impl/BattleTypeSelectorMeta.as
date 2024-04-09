package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   
   public class BattleTypeSelectorMeta extends GFInjectComponent
   {
       
      
      public var startFirstShowAnimation:Function;
      
      public var startIdleAnimation:Function;
      
      public function BattleTypeSelectorMeta()
      {
         super();
      }
      
      public function startFirstShowAnimationS() : void
      {
         App.utils.asserter.assertNotNull(this.startFirstShowAnimation,"startFirstShowAnimation" + Errors.CANT_NULL);
         this.startFirstShowAnimation();
      }
      
      public function startIdleAnimationS() : void
      {
         App.utils.asserter.assertNotNull(this.startIdleAnimation,"startIdleAnimation" + Errors.CANT_NULL);
         this.startIdleAnimation();
      }
   }
}
