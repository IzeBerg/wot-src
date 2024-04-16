package net.wg.gui.lobby.storage.categories.blueprints
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.common.containers.EqualGapsHorizontalLayout;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.utils.IStageSizeDependComponent;
   
   public class BlueprintFragmentsBar extends GroupEx implements IStageSizeDependComponent
   {
       
      
      public function BlueprintFragmentsBar()
      {
         super();
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         if(_width != param1 || _height != param2)
         {
            EqualGapsHorizontalLayout(this.layout).availableSize = param1;
            invalidateLayout();
         }
         super.setSize(param1,param2);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         itemRendererLinkage = Linkages.BLUEPRINTS_NATIONS_BAR_RENDERER;
         this.layout = new EqualGapsHorizontalLayout();
         App.stageSizeMgr.register(this);
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         invalidateLayout();
      }
   }
}
