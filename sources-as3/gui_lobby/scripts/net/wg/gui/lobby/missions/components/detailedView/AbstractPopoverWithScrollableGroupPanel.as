package net.wg.gui.lobby.missions.components.detailedView
{
   import flash.display.DisplayObject;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.containers.GroupLayout;
   import net.wg.gui.components.containers.IGroupEx;
   import net.wg.gui.components.containers.VerticalGroupLayout;
   import net.wg.gui.lobby.components.AbstractPopoverWithScrollableComponentPanel;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class AbstractPopoverWithScrollableGroupPanel extends AbstractPopoverWithScrollableComponentPanel
   {
       
      
      protected var renderersGroup:IGroupEx;
      
      public function AbstractPopoverWithScrollableGroupPanel()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         scrollpane.removeChild(DisplayObject(this.renderersGroup));
         this.renderersGroup = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.createRendererGroup();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(vo != null && isInvalid(InvalidationType.DATA))
         {
            if(scrollpane.target)
            {
               scrollpane.removeChild(DisplayObject(this.renderersGroup));
               this.createRendererGroup();
            }
            this.renderersGroup.itemRendererLinkage = this.groupRendererLinkage;
            this.renderersGroup.dataProvider = this.groupData;
            scrollpane.invalidateSize();
         }
      }
      
      protected function groupLayout() : GroupLayout
      {
         return new VerticalGroupLayout();
      }
      
      private function createRendererGroup() : void
      {
         var _loc1_:GroupLayout = this.groupLayout();
         _loc1_.gap = this.layoutGap;
         this.renderersGroup = new GroupEx();
         this.renderersGroup.layout = _loc1_;
         this.renderersGroup.width = body.width;
         scrollpane.addChild(DisplayObject(this.renderersGroup));
         scrollpane.target = DisplayObject(this.renderersGroup);
      }
      
      protected function get groupData() : IDataProvider
      {
         throw new AbstractException(OVERRIDE_EXCEPTION_MESSAGE);
      }
      
      protected function get layoutGap() : int
      {
         throw new AbstractException(OVERRIDE_EXCEPTION_MESSAGE);
      }
      
      protected function get groupRendererLinkage() : String
      {
         throw new AbstractException(OVERRIDE_EXCEPTION_MESSAGE);
      }
   }
}
