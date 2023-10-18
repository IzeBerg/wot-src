package net.wg.gui.lobby.rankedBattles19.components.divisionProgress
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.gui.components.controls.interfaces.IArrowButton;
   import net.wg.gui.lobby.rankedBattles19.components.StepsContainer;
   import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.helpers.AbstractDivisionState;
   import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.helpers.ActiveDivisionState;
   import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.helpers.BlockViewParams;
   import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.helpers.FirstEnterDivisionState;
   import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.helpers.InactiveDivisionState;
   import net.wg.gui.lobby.rankedBattles19.data.DivisionProgressBlockVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesDivisionProgressVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.Padding;
   
   public class DivisionProgressBlock extends UIComponentEx implements IStageSizeDependComponent
   {
      
      private static const MAX_WIDTH:int = 1600;
      
      private static const BOUNDARIES_INVALID:String = "boundariesInvalid";
      
      private static const STEPS_WIDTH_DEFAULT:int = 79;
      
      private static const STEPS_WIDTH_GAP:int = 15;
       
      
      public var stepsContainer:StepsContainer = null;
      
      public var arrowLeft:IArrowButton = null;
      
      public var arrowRight:IArrowButton = null;
      
      private var _renderers:Vector.<DivisionProgressRankRenderer> = null;
      
      private var _container:Sprite = null;
      
      private var _data:RankedBattlesDivisionProgressVO = null;
      
      private var _blockParams:BlockViewParams = null;
      
      private var _sizePaddings:Padding = null;
      
      private var _visibleRenderersCount:int = 0;
      
      private var _selectedIndex:int = -1;
      
      private var _activeState:AbstractDivisionState = null;
      
      private var _inactiveState:AbstractDivisionState = null;
      
      private var _firstEnterAnimationState:AbstractDivisionState = null;
      
      private var _currentState:AbstractDivisionState = null;
      
      private var _showFirstEnter:Boolean = false;
      
      private var _boundariesWidth:int = 0;
      
      private var _boundariesHeight:int = 0;
      
      private var _maxStepWidth:int = 0;
      
      private var _cachedStepWidths:Vector.<int> = null;
      
      public function DivisionProgressBlock()
      {
         super();
         this._cachedStepWidths = new Vector.<int>(0);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._blockParams = BlockViewParams.BIG;
         this._activeState = new ActiveDivisionState(this);
         this._inactiveState = new InactiveDivisionState(this);
         this._firstEnterAnimationState = new FirstEnterDivisionState(this,this._activeState);
         this._renderers = new Vector.<DivisionProgressRankRenderer>();
         this.stepsContainer.componentSize = RANKEDBATTLES_ALIASES.WIDGET_MEDIUM;
         this.arrowLeft.addEventListener(ButtonEvent.CLICK,this.onLeftArrowClickHandler);
         this.arrowRight.addEventListener(ButtonEvent.CLICK,this.onRightArrowClickHandler);
         this.arrowLeft.visible = false;
         this.arrowRight.visible = false;
         this.arrowLeft.soundType = SoundTypes.RANKED_BATTLES_ARROW;
         this.arrowRight.soundType = SoundTypes.RANKED_BATTLES_ARROW;
         this._container = new Sprite();
         addChildAt(this._container,0);
         App.stageSizeMgr.register(this);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:DivisionProgressRankRenderer = null;
         for each(_loc1_ in this._renderers)
         {
            _loc1_.dispose();
            this._container.removeChild(_loc1_);
         }
         this._renderers.length = 0;
         this._renderers = null;
         removeChild(this._container);
         this._container = null;
         this._data = null;
         this._blockParams = null;
         this.arrowLeft.removeEventListener(ButtonEvent.CLICK,this.onLeftArrowClickHandler);
         this.arrowLeft.dispose();
         this.arrowLeft = null;
         this.arrowRight.removeEventListener(ButtonEvent.CLICK,this.onRightArrowClickHandler);
         this.arrowRight.dispose();
         this.arrowRight = null;
         this.stepsContainer.dispose();
         this.stepsContainer = null;
         this._activeState.dispose();
         this._activeState = null;
         this._inactiveState.dispose();
         this._inactiveState = null;
         this._firstEnterAnimationState.dispose();
         this._firstEnterAnimationState = null;
         this._currentState = null;
         this._sizePaddings = null;
         this._cachedStepWidths.length = 0;
         this._cachedStepWidths = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         super.draw();
         if(this._data)
         {
            _loc1_ = isInvalid(BOUNDARIES_INVALID);
            _loc2_ = isInvalid(InvalidationType.SIZE);
            if(isInvalid(InvalidationType.DATA))
            {
               this.updateData();
               _loc1_ = true;
            }
            if(_loc1_)
            {
               this.updateViewParams();
               _loc2_ = true;
            }
            if(_loc2_)
            {
               this.updateLayout();
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
      }
      
      public function getCachedStepsWidth(param1:int) : int
      {
         return this._cachedStepWidths[param1];
      }
      
      public function setData(param1:RankedBattlesDivisionProgressVO) : void
      {
         this._data = param1;
         this._showFirstEnter = param1.isFirstEnter;
         invalidateData();
      }
      
      public function setSizePadding(param1:Padding) : void
      {
         this._sizePaddings = param1;
         invalidateSize();
      }
      
      public function setState(param1:AbstractDivisionState) : void
      {
         if(this._currentState)
         {
            this._currentState.stop();
         }
         this._currentState = param1;
         this._currentState.start();
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         if(param1 == this._boundariesWidth && param2 == this._boundariesHeight)
         {
            return;
         }
         this._boundariesWidth = param1;
         this._boundariesHeight = param2;
         invalidate(BOUNDARIES_INVALID);
      }
      
      public function updateArrows() : void
      {
         if(this._data && !this._data.isLocked)
         {
            this.arrowLeft.enabled = this._selectedIndex > 0;
            this.arrowRight.enabled = this._selectedIndex < this._data.blocks.length - 1;
         }
         else
         {
            this.arrowLeft.enabled = false;
            this.arrowRight.enabled = false;
         }
      }
      
      public function updateSteps() : void
      {
         this.stepsContainer.visible = true;
         this.stepsContainer.setData(this._data.blocks[this._selectedIndex].stepsData);
         this.stepsContainer.validateNow();
         invalidateSize();
      }
      
      private function updateData() : void
      {
         var _loc6_:int = 0;
         var _loc1_:DivisionProgressRankRenderer = null;
         var _loc2_:DivisionProgressBlockVO = null;
         var _loc3_:int = this._data.blocks.length;
         this._maxStepWidth = 0;
         this._cachedStepWidths.length = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = this._data.blocks[_loc4_];
            if(_loc4_ == this._renderers.length)
            {
               _loc1_ = App.utils.classFactory.getComponent(Linkages.RANKED_BATTLES_DIVISION_RANK_RENDERER_UI,DivisionProgressRankRenderer) as DivisionProgressRankRenderer;
               this._container.addChild(_loc1_);
               this._renderers[_loc4_] = _loc1_;
            }
            else
            {
               _loc1_ = this._renderers[_loc4_];
            }
            _loc1_.setData(this._data.blocks[_loc4_]);
            _loc6_ = STEPS_WIDTH_DEFAULT + _loc2_.stepsData.steps.length * STEPS_WIDTH_GAP;
            this._cachedStepWidths[_loc4_] = _loc6_;
            if(_loc6_ > this._maxStepWidth)
            {
               this._maxStepWidth = _loc6_;
            }
            _loc4_++;
         }
         var _loc5_:AbstractDivisionState = null;
         if(this._data.isLocked || this._data.blocks[this._data.blocks.length - 1].isAcquired)
         {
            _loc5_ = this._inactiveState;
         }
         else if(this._showFirstEnter)
         {
            _loc5_ = this._firstEnterAnimationState;
            this._showFirstEnter = false;
         }
         else
         {
            _loc5_ = this._activeState;
         }
         this.setState(_loc5_);
      }
      
      private function updateViewParams() : void
      {
         var _loc1_:int = 0;
         if(this._boundariesWidth < StageSizeBoundaries.WIDTH_1920 || this._boundariesHeight < StageSizeBoundaries.HEIGHT_900)
         {
            _loc1_ = this._currentState == this._inactiveState ? int(StageSizeBoundaries.WIDTH_1600) : int(StageSizeBoundaries.WIDTH_1366);
            this._blockParams = this._boundariesWidth < _loc1_ ? BlockViewParams.SMALL : BlockViewParams.BIG;
         }
         else
         {
            this._blockParams = BlockViewParams.HUGE;
         }
      }
      
      private function updateLayout() : void
      {
         var _loc5_:DivisionProgressRankRenderer = null;
         var _loc6_:int = 0;
         var _loc1_:int = this.blockParams.firstStep + (this._maxStepWidth >> 1);
         var _loc2_:int = _loc1_ + this._blockParams.secondStep;
         var _loc3_:int = Math.min(MAX_WIDTH,width - 2 * this._sizePaddings.left);
         var _loc4_:int = (_loc3_ >> 1) - _loc2_;
         this._visibleRenderersCount = 2 * (int(_loc4_ / this._blockParams.regularStep) + 1);
         for each(_loc5_ in this._renderers)
         {
            _loc5_.blockParams = this._blockParams;
         }
         this._currentState.updateSize();
         _loc6_ = _loc2_ + this._blockParams.regularStep * ((this._visibleRenderersCount >> 1) - 1) | 0;
         this.arrowLeft.x = -_loc6_;
         this.arrowRight.x = _loc6_;
         if(this.stepsContainer.visible)
         {
            this.stepsContainer.x = this._selectedIndex == 0 ? Number(-this.blockParams.firstStep - this.stepsContainer.width) : Number(-(this.stepsContainer.width >> 1));
            this.stepsContainer.y = -(this.stepsContainer.height >> 1);
         }
      }
      
      override public function get height() : Number
      {
         return Boolean(this._blockParams) ? Number(this._blockParams.bigRank.height) : Number(super.height);
      }
      
      public function get renderers() : Vector.<DivisionProgressRankRenderer>
      {
         return this._renderers;
      }
      
      public function get blockParams() : BlockViewParams
      {
         return this._blockParams;
      }
      
      public function get data() : RankedBattlesDivisionProgressVO
      {
         return this._data;
      }
      
      public function get selectedIndex() : int
      {
         return this._selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         if(this._data)
         {
            param1 = Math.max(0,Math.min(param1,this._data.blocks.length - 1));
         }
         if(this._selectedIndex != param1)
         {
            this._selectedIndex = param1;
            dispatchEvent(new Event(Event.SELECT));
         }
      }
      
      public function get visibleRenderersCount() : int
      {
         return this._visibleRenderersCount;
      }
      
      private function onLeftArrowClickHandler(param1:ButtonEvent) : void
      {
         --this.selectedIndex;
      }
      
      private function onRightArrowClickHandler(param1:ButtonEvent) : void
      {
         ++this.selectedIndex;
      }
   }
}
