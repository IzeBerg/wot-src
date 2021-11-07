package net.wg.gui.lobby.rankedBattles19.components.divisionSelector
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.interfaces.IArrowButton;
   import net.wg.gui.lobby.rankedBattles19.data.DivisionVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.motion.Tween;
   
   public class DivisionSelector extends UIComponentEx
   {
      
      private static const MIN_ITEMS_LEN:int = 1;
      
      private static const INV_ARROW_SIZE:String = "invalidateArrowSize";
      
      private static const ARROW_HEIGHT_NORMAL:int = 102;
      
      private static const ARROW_HEIGHT_SHORT:int = 68;
       
      
      public var leftArrow:IArrowButton = null;
      
      public var rightArrow:IArrowButton = null;
      
      public var divisionName:DivisionSelectorName = null;
      
      private var _selectedIndex:int = -1;
      
      private var _divisions:Vector.<DivisionVO> = null;
      
      private var _len:int = 0;
      
      private var _immediately:Boolean = false;
      
      private var _tweenDuration:int = 0;
      
      private var _centerPos:int = 0;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _divisionNameTween:Tween = null;
      
      private var _easeHideFn:Function = null;
      
      private var _easeShowFn:Function = null;
      
      private var _isShort:Boolean = false;
      
      public function DivisionSelector()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._tooltipMgr = App.toolTipMgr;
         this._centerPos = this.rightArrow.x - this.leftArrow.x >> 1;
         this.leftArrow.addEventListener(ButtonEvent.CLICK,this.onLeftArrowClickHandler);
         this.rightArrow.addEventListener(ButtonEvent.CLICK,this.onRightArrowClickHandler);
         this.divisionName.addEventListener(Event.RESIZE,this.onDivisionNameResizeHandler);
         this.divisionName.addEventListener(MouseEvent.MOUSE_OVER,this.onDivisionNameMouseOverHandler);
         this.divisionName.addEventListener(MouseEvent.MOUSE_OUT,this.onDivisionNameMouseOutHandler);
         this.divisionName.addEventListener(MouseEvent.CLICK,this.onDivisionNameClickHandler);
         this.leftArrow.soundType = SoundTypes.RANKED_BATTLES_ARROW;
         this.rightArrow.soundType = SoundTypes.RANKED_BATTLES_ARROW;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.draw();
         if(this._divisions)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.dataUpdate();
            }
            if(isInvalid(INV_ARROW_SIZE))
            {
               _loc1_ = !!this._isShort ? int(ARROW_HEIGHT_SHORT) : int(ARROW_HEIGHT_NORMAL);
               this.leftArrow.height = this.rightArrow.height = _loc1_;
               _loc2_ = ARROW_HEIGHT_NORMAL - _loc1_ >> 1;
               this.leftArrow.y = _loc2_;
               this.rightArrow.y = _loc2_ + _loc1_;
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.doResize();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.clearDivisionNameTween();
         this.leftArrow.removeEventListener(ButtonEvent.CLICK,this.onLeftArrowClickHandler);
         this.leftArrow.dispose();
         this.leftArrow = null;
         this.rightArrow.removeEventListener(ButtonEvent.CLICK,this.onRightArrowClickHandler);
         this.rightArrow.dispose();
         this.rightArrow = null;
         this.divisionName.removeEventListener(Event.RESIZE,this.onDivisionNameResizeHandler);
         this.divisionName.removeEventListener(MouseEvent.MOUSE_OVER,this.onDivisionNameMouseOverHandler);
         this.divisionName.removeEventListener(MouseEvent.MOUSE_OUT,this.onDivisionNameMouseOutHandler);
         this.divisionName.removeEventListener(MouseEvent.CLICK,this.onDivisionNameClickHandler);
         this.divisionName.dispose();
         this.divisionName = null;
         this._tooltipMgr.hide();
         this._tooltipMgr = null;
         this._easeHideFn = null;
         this._easeShowFn = null;
         this._divisions = null;
         super.onDispose();
      }
      
      public function setData(param1:Vector.<DivisionVO>, param2:Boolean, param3:int, param4:Function, param5:Function) : void
      {
         this._easeShowFn = param4;
         this._easeHideFn = param5;
         this._tweenDuration = param3;
         this._divisions = param1;
         this._immediately = param2;
         invalidateData();
      }
      
      public function setSelectedIndex(param1:int, param2:Boolean) : void
      {
         if(this._divisions)
         {
            this.setSelectedItem(param1);
            this.doResize();
            this.showHideContent(true,param2);
         }
      }
      
      private function doResize() : void
      {
         this.divisionName.x = this._centerPos - (this.divisionName.width >> 1);
      }
      
      private function changeByArrowsIndex(param1:int) : void
      {
         if(this._len > MIN_ITEMS_LEN)
         {
            if(param1 < Values.ZERO || param1 >= this._len)
            {
               return;
            }
            this.leftArrow.enabled = this.rightArrow.enabled = false;
            this.showHideContent(false,false);
            dispatchEvent(new IndexEvent(IndexEvent.INDEX_CHANGE,false,true,param1,this._selectedIndex,this._divisions[param1]));
         }
      }
      
      private function dataUpdate() : void
      {
         this._len = this._divisions.length;
         var _loc1_:int = Values.ZERO;
         while(_loc1_ < this._len)
         {
            if(this._divisions[_loc1_].isCurrent)
            {
               if(!this._immediately)
               {
                  dispatchEvent(new IndexEvent(IndexEvent.INDEX_CHANGE,false,true,_loc1_,this._selectedIndex,this._divisions[_loc1_]));
               }
               this.setSelectedIndex(_loc1_,this._immediately);
               break;
            }
            _loc1_++;
         }
         this._immediately = false;
      }
      
      private function setSelectedItem(param1:int) : void
      {
         if(this._selectedIndex == param1)
         {
            return;
         }
         this._selectedIndex = param1;
         this.divisionName.setData(this._divisions[this._selectedIndex]);
         if(this._tooltipMgr)
         {
            this._tooltipMgr.hide();
         }
      }
      
      private function clearDivisionNameTween() : void
      {
         if(this._divisionNameTween)
         {
            this._divisionNameTween.paused = true;
            this._divisionNameTween.dispose();
            this._divisionNameTween = null;
         }
      }
      
      private function showHideContent(param1:Boolean, param2:Boolean) : void
      {
         var _loc4_:Function = null;
         this.clearDivisionNameTween();
         var _loc3_:Number = !!param1 ? Number(Values.DEFAULT_ALPHA) : Number(Values.ZERO);
         if(_loc3_ != this.divisionName.alpha)
         {
            if(param2)
            {
               this.divisionName.alpha = _loc3_;
               this.onContentAnimCompleted(null);
            }
            else
            {
               _loc4_ = !!param1 ? this._easeShowFn : this._easeHideFn;
               this._divisionNameTween = new Tween(this._tweenDuration,this.divisionName,{"alpha":_loc3_},{
                  "paused":false,
                  "ease":_loc4_,
                  "onComplete":this.onContentAnimCompleted
               });
            }
         }
         else
         {
            this.onContentAnimCompleted(null);
         }
      }
      
      private function onContentAnimCompleted(param1:Tween) : void
      {
         if(this.divisionName.alpha == Values.DEFAULT_ALPHA)
         {
            this.updateArrowsEnabled();
            if(this.divisionName.hitTestPoint(App.stage.mouseX,App.stage.mouseY))
            {
               this.showTooltip();
            }
         }
      }
      
      private function updateArrowsEnabled() : void
      {
         this.leftArrow.enabled = this._selectedIndex != Values.ZERO;
         this.rightArrow.enabled = this._selectedIndex != this._len - 1;
      }
      
      private function showTooltip() : void
      {
         var _loc1_:DivisionVO = null;
         if(this._selectedIndex != Values.DEFAULT_INT && this._divisions)
         {
            _loc1_ = this._divisions[this._selectedIndex];
            this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.RANKED_DIVISION_INFO,null,_loc1_.id,_loc1_.isCurrent,_loc1_.isLocked,_loc1_.isCompleted);
         }
      }
      
      private function hideTooltip() : void
      {
         this._tooltipMgr.hide();
      }
      
      public function set isShort(param1:Boolean) : void
      {
         if(this._isShort == param1)
         {
            return;
         }
         this._isShort = param1;
         invalidate(INV_ARROW_SIZE);
      }
      
      private function onDivisionNameMouseOverHandler(param1:MouseEvent) : void
      {
         this.showTooltip();
      }
      
      private function onDivisionNameMouseOutHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
      
      private function onDivisionNameClickHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
      
      private function onDivisionNameResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onLeftArrowClickHandler(param1:ButtonEvent) : void
      {
         this.changeByArrowsIndex(this._selectedIndex - 1);
      }
      
      private function onRightArrowClickHandler(param1:ButtonEvent) : void
      {
         this.changeByArrowsIndex(this._selectedIndex + 1);
      }
   }
}
