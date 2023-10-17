package net.wg.gui.lobby.components
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.common.containers.Vertical100PercWidthLayout;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class DetailedStatisticsRootUnit extends DetailedStatisticsGroupEx implements IUpdatable
   {
      
      private static const GAP:int = 20;
       
      
      public function DetailedStatisticsRootUnit()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:Vertical100PercWidthLayout = new Vertical100PercWidthLayout();
         _loc1_.gap = GAP;
         layout = _loc1_;
         unitRendererLinkage = Linkages.STATISTICS_DASH_LINE_TEXT_ITEM_RENDERER;
      }
      
      public function update(param1:Object) : void
      {
         dataProvider = IDataProvider(param1);
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         invalidateLayout();
      }
   }
}
