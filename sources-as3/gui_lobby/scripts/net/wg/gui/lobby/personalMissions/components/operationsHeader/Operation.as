package net.wg.gui.lobby.personalMissions.components.operationsHeader
{
   import fl.motion.easing.Cubic;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import net.wg.data.constants.generated.PERSONAL_MISSIONS_ALIASES;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.personalMissions.data.OperationVO;
   import net.wg.gui.lobby.personalMissions.events.OperationEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IScheduler;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class Operation extends UIComponentEx implements IUpdatableComponent
   {
      
      private static const STATE_SELECTED_PREFIX:String = "selected_";
      
      private static const DISABLED_STATES:Array = [PERSONAL_MISSIONS_ALIASES.OPERATION_DISABLED_STATE,PERSONAL_MISSIONS_ALIASES.OPERATION_POSTPONED_STATE];
      
      private static const TEXT_ALPHA_DEF:Number = 0;
      
      private static const TEXT_ALPHA_SELECTED:Number = 1;
      
      private static const ICON_ALPHA_DEF:Number = 0.6;
      
      private static const ICON_ALPHA_SELECTED:Number = 1;
      
      private static const ICON_SCALE_DEF:Number = 0.75;
      
      private static const ICON_SCALE_SELECTED:Number = 1;
      
      private static const FREE_SHEET_ICON_OFFSET_SELECTED:Number = -10;
      
      private static const TWEEN_TIME_DEF:int = 500;
      
      private static const TWEEN_QUICKSET_DEF:Object = {
         "ease":Cubic.easeInOut,
         "paused":false
      };
      
      private static const TWEEN_QUICKSET_DESC_DEF:Object = {
         "ease":Cubic.easeOut,
         "paused":false
      };
      
      private static const TWEEN_ICON_PARAMS_DEF:Object = {
         "x":1,
         "y":12,
         "scaleX":ICON_SCALE_DEF,
         "scaleY":ICON_SCALE_DEF,
         "alpha":ICON_ALPHA_DEF
      };
      
      private static const TWEEN_ICON_PARAMS_SELECTED:Object = {
         "x":-20,
         "y":0,
         "scaleX":ICON_SCALE_SELECTED,
         "scaleY":ICON_SCALE_SELECTED,
         "alpha":ICON_ALPHA_SELECTED
      };
      
      private static const TWEEN_ICONSTATE_PARAMS_DEF:Object = {"x":87};
      
      private static const TWEEN_ICONSTATE_PARAMS_SELECTED:Object = {"x":110};
      
      private static const TWEEN_DESC_PARAMS_DEF:Object = {"alpha":0};
      
      private static const TWEEN_DESC_PARAMS_SELECTED:Object = {"alpha":1};
      
      private static const TWEEN_FREESHEETS_TIME:int = 350;
      
      private static const TWEEN_FREESHEETS_PARAMS_DEF:Object = {"x":91};
      
      private static const TOOLTIP_DELAY:int = 500;
      
      private static const TWEEN_FADE_TIME:Number = 250;
       
      
      public var hit:Sprite = null;
      
      public var description:OperationDescription;
      
      public var icon:UILoaderAlt;
      
      public var iconState:UILoaderAlt;
      
      public var freeSheets:FreeSheetsCounter;
      
      public var hover:Sprite;
      
      public var id:int = -1;
      
      private var _state:String;
      
      private var _selected:Boolean = false;
      
      private var _data:OperationVO = null;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      private var _scheduler:IScheduler = null;
      
      private var _tweensDict:Dictionary;
      
      private var _playAnim:Boolean = false;
      
      private var _isStateEnabled:Boolean = true;
      
      public function Operation()
      {
         this._tweensDict = new Dictionary(true);
         super();
      }
      
      private static function setProps(param1:Object, param2:Object) : void
      {
         var _loc3_:* = null;
         for(_loc3_ in param2)
         {
            param1[_loc3_] = param2[_loc3_];
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._state = PERSONAL_MISSIONS_ALIASES.OPERATION_UNLOCKED_STATE;
         this._tooltipMgr = App.toolTipMgr;
         this._scheduler = App.utils.scheduler;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         hitArea = this.hit;
         this.icon.alpha = ICON_ALPHA_DEF;
         this.icon.scaleX = this.icon.scaleX = ICON_SCALE_DEF;
         this.icon.visible = this.iconState.visible = this.description.visible = this.freeSheets.visible = false;
         this.icon.mouseChildren = this.icon.mouseEnabled = false;
         addEventListener(MouseEvent.CLICK,this.onClickHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.hover.mouseEnabled = false;
         this.hover.visible = false;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:Tween = null;
         stop();
         removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.icon.dispose();
         this.icon = null;
         this.iconState.dispose();
         this.iconState = null;
         this.freeSheets.dispose();
         this.freeSheets = null;
         this.description.dispose();
         this.description = null;
         this.hit = null;
         this.hover = null;
         this._tooltipMgr = null;
         this._data = null;
         this._scheduler.cancelTask(this.showTooltip);
         this._scheduler = null;
         for each(_loc1_ in this._tweensDict)
         {
            _loc1_.dispose();
         }
         App.utils.data.cleanupDynamicObject(this._tweensDict);
         this._tweensDict = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.selected = this._data.isSelected;
               this.id = this._data.id;
               this._state = this._data.state;
               this.icon.source = this._data.iconSource;
               this.icon.visible = true;
               this.iconState.visible = StringUtils.isNotEmpty(this._data.iconStateSource);
               if(this.iconState.visible)
               {
                  this.iconState.source = this._data.iconStateSource;
               }
               this.description.title = this._data.title;
               this.description.description = this._data.desc;
               this.description.setState(this._state);
               this.freeSheets.visible = StringUtils.isNotEmpty(this._data.freeSheetIconSource);
               if(this.freeSheets.visible)
               {
                  this.freeSheets.iconSource = this._data.freeSheetIconSource;
                  this.freeSheets.counterText = this._data.freeSheetCounter;
               }
               this._isStateEnabled = DISABLED_STATES.indexOf(this._data.state) == -1;
               buttonMode = useHandCursor = this._isStateEnabled;
               invalidateState();
            }
            if(isInvalid(InvalidationType.STATE))
            {
               this.setState();
               if(this._playAnim)
               {
                  this.playTween(TWEEN_TIME_DEF,this.icon,!!this._selected ? TWEEN_ICON_PARAMS_SELECTED : TWEEN_ICON_PARAMS_DEF,TWEEN_QUICKSET_DEF);
               }
               else
               {
                  setProps(this.icon,!!this._selected ? TWEEN_ICON_PARAMS_SELECTED : TWEEN_ICON_PARAMS_DEF);
               }
               if(this.iconState.visible)
               {
                  if(this._playAnim)
                  {
                     this.playTween(TWEEN_TIME_DEF,this.iconState,!!this._selected ? TWEEN_ICONSTATE_PARAMS_SELECTED : TWEEN_ICONSTATE_PARAMS_DEF,TWEEN_QUICKSET_DEF);
                  }
                  else
                  {
                     setProps(this.iconState,!!this._selected ? TWEEN_ICONSTATE_PARAMS_SELECTED : TWEEN_ICONSTATE_PARAMS_DEF);
                  }
               }
               this.description.visible = this.description.visible || this._selected;
               TWEEN_QUICKSET_DESC_DEF.onComplete = !!this._selected ? null : this.onTweenTextDefCompleteHandler;
               if(!(this._selected && this.description.visible && this.description.alpha == TEXT_ALPHA_SELECTED))
               {
                  this.description.alpha = !!this._selected ? Number(TEXT_ALPHA_DEF) : Number(TEXT_ALPHA_SELECTED);
                  if(this._playAnim)
                  {
                     this.playTween(TWEEN_TIME_DEF,this.description,!!this._selected ? TWEEN_DESC_PARAMS_SELECTED : TWEEN_DESC_PARAMS_DEF,!!this._selected ? TWEEN_QUICKSET_DEF : TWEEN_QUICKSET_DESC_DEF);
                  }
                  else
                  {
                     setProps(this.description,!!this._selected ? TWEEN_DESC_PARAMS_SELECTED : TWEEN_DESC_PARAMS_DEF);
                  }
               }
               if(this.freeSheets.visible)
               {
                  _loc1_ = this.description.x + this.description.titleWidth + FREE_SHEET_ICON_OFFSET_SELECTED;
                  if(this._playAnim)
                  {
                     this.playTween(TWEEN_FREESHEETS_TIME,this.freeSheets,!!this._selected ? {"x":_loc1_} : TWEEN_FREESHEETS_PARAMS_DEF,TWEEN_QUICKSET_DEF);
                  }
                  else
                  {
                     setProps(this.freeSheets,!!this._selected ? {"x":_loc1_} : TWEEN_FREESHEETS_PARAMS_DEF);
                  }
               }
            }
         }
      }
      
      public function update(param1:Object) : void
      {
         if(param1 != null && this._data != param1)
         {
            this._data = OperationVO(param1);
            invalidateData();
         }
      }
      
      private function onTweenCompleteHandler(param1:Tween) : void
      {
         param1.dispose();
      }
      
      private function setState() : void
      {
         gotoAndPlay(!!this._selected ? STATE_SELECTED_PREFIX + this._state : this._state);
      }
      
      private function showTooltip() : void
      {
         this._scheduler.cancelTask(this.showTooltip);
         if(this._data)
         {
            this._tooltipMgr.showSpecial(this._data.tooltipAlias,null,this.id);
         }
      }
      
      private function playHoverFadeTween(param1:Boolean) : void
      {
         this.playTween(TWEEN_FADE_TIME,this.hover,{"alpha":(!!param1 ? 1 : 0)},{"onComplete":(!!param1 ? null : this.onHoverFadeOutCompleteHandler)});
         this.playTween(TWEEN_FADE_TIME,this.icon,{"alpha":(!!param1 ? ICON_ALPHA_SELECTED : ICON_ALPHA_DEF)});
      }
      
      private function playTween(param1:Number, param2:Object, param3:Object, param4:Object = null) : void
      {
         if(param4 == null)
         {
            param4 = {};
         }
         if(param4.onComplete == null)
         {
            param4.onComplete = this.onTweenCompleteHandler;
         }
         this._tweensDict[param2.name] = new Tween(param1,param2,param3,param4);
      }
      
      private function onTweenTextDefCompleteHandler(param1:Tween) : void
      {
         if(!this._selected)
         {
            this.description.visible = false;
         }
         this.onTweenCompleteHandler(param1);
      }
      
      private function onHoverFadeOutCompleteHandler(param1:Tween) : void
      {
         this.hover.visible = false;
         this.onTweenCompleteHandler(param1);
      }
      
      override public function get width() : Number
      {
         return this.hit.width;
      }
      
      override public function get height() : Number
      {
         return this.hit.height;
      }
      
      public function get playAnim() : Boolean
      {
         return this._playAnim;
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(this._selected != param1)
         {
            this._selected = param1;
            invalidateState();
         }
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         if(this._isStateEnabled && !this._selected && App.utils.commons.isLeftButton(param1))
         {
            this._playAnim = true;
            dispatchEvent(new OperationEvent(OperationEvent.CLICK));
            this.playHoverFadeTween(false);
         }
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this._scheduler.scheduleTask(this.showTooltip,TOOLTIP_DELAY);
         if(this._isStateEnabled && !this._selected)
         {
            this.hover.alpha = 0;
            this.hover.visible = true;
            this.playHoverFadeTween(true);
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._scheduler.cancelTask(this.showTooltip);
         this._tooltipMgr.hide();
         if(this._isStateEnabled && !this._selected)
         {
            this.playHoverFadeTween(false);
         }
      }
   }
}
