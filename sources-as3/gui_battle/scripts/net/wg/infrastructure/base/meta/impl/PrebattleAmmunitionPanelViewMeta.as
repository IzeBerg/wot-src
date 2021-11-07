package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   
   public class PrebattleAmmunitionPanelViewMeta extends GFInjectComponent
   {
       
      
      public var onViewIsHidden:Function;
      
      public function PrebattleAmmunitionPanelViewMeta()
      {
         super();
      }
      
      public function onViewIsHiddenS() : void
      {
         App.utils.asserter.assertNotNull(this.onViewIsHidden,"onViewIsHidden" + Errors.CANT_NULL);
         this.onViewIsHidden();
      }
   }
}
