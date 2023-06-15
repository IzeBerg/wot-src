package net.wg.gui.lobby.storage.categories
{
   import flash.display.InteractiveObject;
   import net.wg.gui.components.carousels.ScrollCarousel;
   import net.wg.gui.lobby.storage.categories.cards.configs.CardConfigs;
   import net.wg.gui.lobby.storage.categories.cards.configs.CardSizeVO;
   import net.wg.infrastructure.interfaces.IFocusChainContainer;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   
   public class StorageCarousel extends ScrollCarousel implements IFocusChainContainer, IStageSizeDependComponent
   {
       
      
      public function StorageCarousel()
      {
         super();
         roundCountRenderer = false;
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         param1 = App.stageSizeMgr.calcAllowSize(param1,CardConfigs.getInstance().allowCardsResolution);
         var _loc3_:CardSizeVO = CardConfigs.getInstance().cardSize.getConfig(param1);
         var _loc4_:int = param1 == StageSizeBoundaries.WIDTH_1024 ? int(3) : int(4);
         scrollList.columnCount = _loc4_;
         scrollList.rendererWidth = _loc3_.size.width;
         scrollList.rendererHeight = _loc3_.size.height;
         scrollList.verticalGap = _loc3_.outerPadding;
         scrollList.horizontalGap = _loc3_.outerPadding;
         scrollList.pageHeight = scrollList.rendererHeight + scrollList.verticalGap;
         scrollList.width = (scrollList.rendererWidth + scrollList.horizontalGap) * _loc4_ - scrollList.horizontalGap;
         this.width = scrollList.width;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         App.stageSizeMgr.register(this);
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
         scrollList.height = param2;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         scrollList.mouseWheelDirection = DirectionMode.VERTICAL;
         scrollList.useTimer = true;
         scrollList.hasVerticalElasticEdges = true;
         scrollList.snapScrollPositionToItemRendererSize = false;
         scrollList.snapToPages = true;
         scrollList.cropContent = true;
         scrollList.showRendererOnlyIfDataExists = true;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            scrollList.viewPort.invalidate(InvalidationType.DATA);
         }
      }
      
      public function getFocusChain() : Vector.<InteractiveObject>
      {
         var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
         if(visible)
         {
            _loc1_.push(scrollList);
         }
         return _loc1_;
      }
   }
}
