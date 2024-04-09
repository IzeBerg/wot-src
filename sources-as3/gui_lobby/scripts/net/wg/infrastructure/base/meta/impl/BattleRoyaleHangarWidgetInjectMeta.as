package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   
   public class BattleRoyaleHangarWidgetInjectMeta extends GFInjectComponent
   {
       
      
      public var playBlinkAnimation:Function;
      
      public function BattleRoyaleHangarWidgetInjectMeta()
      {
         super();
      }
      
      public function playBlinkAnimationS() : void
      {
         App.utils.asserter.assertNotNull(this.playBlinkAnimation,"playBlinkAnimation" + Errors.CANT_NULL);
         this.playBlinkAnimation();
      }
   }
}
