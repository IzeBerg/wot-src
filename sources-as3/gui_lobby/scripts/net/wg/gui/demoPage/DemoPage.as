package net.wg.gui.demoPage
{
   import net.wg.data.constants.generated.LAYER_NAMES;
   import net.wg.gui.components.containers.MainViewContainer;
   import net.wg.gui.components.containers.ManagedContainer;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.components.controls.events.RendererEvent;
   import net.wg.infrastructure.base.meta.IDemoPageMeta;
   import net.wg.infrastructure.base.meta.impl.DemoPageMeta;
   import net.wg.infrastructure.interfaces.IManagedContainer;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.data.DataProvider;
   
   public class DemoPage extends DemoPageMeta implements IDemoPageMeta
   {
      
      private static const LINKAGE_TOGGLE_RENDERER:String = "ButtonDemoRendererUI";
      
      private static const HOT_FILTER_TILE_WIDTH:uint = 150;
      
      private static const HOT_FILTER_TILE_HEIGHT:uint = 22;
       
      
      public var buttonList:SimpleTileList = null;
      
      public var subViewContainer:IManagedContainer = null;
      
      private var _dataProvider:DataProvider;
      
      public function DemoPage()
      {
         super();
      }
      
      override public function getSubContainers() : Array
      {
         return [this.subViewContainer];
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         var _loc4_:IManagedContainer = null;
         var _loc3_:Array = this.getSubContainers();
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_)
            {
               _loc4_.updateStage(param1,param2);
            }
         }
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.subViewContainer = this.addSubContainer(LAYER_NAMES.SUBVIEW,1);
         this.subViewContainer.manageSize = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.updateStage(App.appWidth,App.appHeight);
         this.buttonList.itemRenderer = App.utils.classFactory.getClass(LINKAGE_TOGGLE_RENDERER);
         this.buttonList.tileWidth = HOT_FILTER_TILE_WIDTH;
         this.buttonList.tileHeight = HOT_FILTER_TILE_HEIGHT;
         this.buttonList.verticalGap = 10;
         this.buttonList.directionMode = DirectionMode.VERTICAL;
         this.buttonList.addEventListener(RendererEvent.ITEM_CLICK,this.onButtonListHandler);
      }
      
      override protected function setContent(param1:DataProvider) : void
      {
         this._dataProvider = param1;
         this.buttonList.dataProvider = param1;
      }
      
      override protected function onDispose() : void
      {
         this.buttonList.removeEventListener(RendererEvent.ITEM_CLICK,this.onButtonListHandler);
         this.buttonList.dispose();
         this.buttonList = null;
         this.subViewContainer = null;
         super.onDispose();
      }
      
      private function addSubContainer(param1:String, param2:int) : IManagedContainer
      {
         var _loc3_:ManagedContainer = new MainViewContainer(param1);
         addChildAt(_loc3_,param2);
         return _loc3_;
      }
      
      private function onButtonListHandler(param1:RendererEvent) : void
      {
         onButtonClickedS(this._dataProvider.requestItemAt(param1.index).id);
      }
   }
}
