package net.wg.gui.lobby.components
{
   import flash.display.InteractiveObject;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.common.containers.EqualWidthHorizontalLayout;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.lobby.components.data.DetailedLabelDataVO;
   
   public class DetailedStatisticsView extends GroupEx implements IResizableContent
   {
      
      private static const GAP:int = 50;
       
      
      private var _layout:EqualWidthHorizontalLayout = null;
      
      public function DetailedStatisticsView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._layout = new EqualWidthHorizontalLayout();
         this._layout.gap = GAP;
         this._layout.paddingGap = true;
         layout = this._layout;
         itemRendererLinkage = Linkages.DETAILED_STATISTICS_ROOT_UNIT;
      }
      
      override protected function onDispose() : void
      {
         this._layout.dispose();
         this._layout = null;
         super.onDispose();
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this;
      }
      
      public function setViewSize(param1:Number, param2:Number) : void
      {
         this._layout.availableSize = param1;
         invalidateLayout();
      }
      
      public function update(param1:Object) : void
      {
         if(param1 is DetailedLabelDataVO)
         {
            dataProvider = DetailedLabelDataVO(param1).detailedInfoList;
         }
      }
      
      public function get centerOffset() : int
      {
         return 0;
      }
      
      public function set centerOffset(param1:int) : void
      {
      }
      
      public function get active() : Boolean
      {
         return false;
      }
      
      public function set active(param1:Boolean) : void
      {
      }
   }
}
