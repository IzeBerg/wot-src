package net.wg.gui.lobby.rankedBattles19.view
{
   import flash.events.Event;
   import net.wg.gui.components.advanced.ViewStackExPadding;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.lobby.rankedBattles19.components.divisionsContainer.DivisionsContainer;
   import net.wg.gui.lobby.rankedBattles19.data.DivisionsViewVO;
   import net.wg.infrastructure.base.meta.IRankedBattlesDivisionsViewMeta;
   import net.wg.infrastructure.base.meta.impl.RankedBattlesDivisionsViewMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.utils.IStageSizeDependComponent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.utils.Padding;
   
   public class RankedBattlesDivisionsView extends RankedBattlesDivisionsViewMeta implements IRankedBattlesDivisionsViewMeta, IStageSizeDependComponent
   {
       
      
      public var divisionsContainer:DivisionsContainer = null;
      
      public var content:ViewStackExPadding = null;
      
      private var _data:DivisionsViewVO = null;
      
      private var _viewHelper:RankedBattlesViewHelper = null;
      
      private var _viewSizeId:String = "small";
      
      public function RankedBattlesDivisionsView()
      {
         super();
         this._viewHelper = RankedBattlesViewHelper.getInstance();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.divisionsContainer.addEventListener(IndexEvent.INDEX_CHANGE,this.onDivisionsContainerIndexChangeHandler);
         this.divisionsContainer.addEventListener(Event.RESIZE,this.onDivisionsContainerResizeHandler);
         this.content.cache = true;
         this.content.targetGroup = this.divisionsContainer.name;
         this.content.isApplyPadding = false;
         this.content.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onContentViewChangedHandler);
         App.stageSizeMgr.register(this);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.SIZE,INV_VIEW_PADDING))
            {
               this.updateLayoutHorizontal();
               this.updateLayoutVertical();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.divisionsContainer.removeEventListener(Event.RESIZE,this.onDivisionsContainerResizeHandler);
         this.divisionsContainer.removeEventListener(IndexEvent.INDEX_CHANGE,this.onDivisionsContainerIndexChangeHandler);
         this.divisionsContainer.dispose();
         this.divisionsContainer = null;
         this.content.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onContentViewChangedHandler);
         this.content.dispose();
         this.content = null;
         this._data = null;
         this._viewHelper = null;
         super.onDispose();
      }
      
      override protected function setData(param1:DivisionsViewVO) : void
      {
         this._data = DivisionsViewVO(param1);
         this.divisionsContainer.setData(this._data.divisions);
         this.divisionsContainer.selectedIndex = this._data.selectedDivisionIdx;
         invalidateSize();
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this._viewSizeId = this._viewHelper.getSizeId(param1,param2);
         this.divisionsContainer.isSmall = this._viewSizeId == RankedBattlesViewHelper.SIZE_SMALL;
         invalidateSize();
      }
      
      private function updateLayoutHorizontal() : void
      {
         this.divisionsContainer.x = width - this.divisionsContainer.width >> 1;
      }
      
      private function updateLayoutVertical() : void
      {
         this.content.y = (height >> 1) + this._viewHelper.getDivisionsCenterBlockYOffset(this._viewSizeId);
         this.content.setSize(_width,_height - this.content.y);
         this.content.setSizePadding(new Padding(0,0,0,viewPadding.left));
         this.divisionsContainer.y = this.content.y + this._viewHelper.getDivisionsTopBlockYOffset(this._viewSizeId) | 0;
      }
      
      private function onDivisionsContainerResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onDivisionsContainerIndexChangeHandler(param1:IndexEvent) : void
      {
         onDivisionChangedS(param1.index);
      }
      
      private function onContentViewChangedHandler(param1:ViewStackEvent) : void
      {
         var _loc2_:String = param1.viewId;
         if(!isFlashComponentRegisteredS(_loc2_))
         {
            registerFlashComponentS(IDAAPIModule(param1.view),_loc2_);
         }
         dispatchEvent(new Event(Event.CHANGE));
      }
   }
}
